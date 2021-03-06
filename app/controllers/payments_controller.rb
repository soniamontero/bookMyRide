class PaymentsController < ApplicationController
   before_action :booking_exists?, :set_booking

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,  # You should store this customer id and re-use it.
      amount:       @booking.amount_cents,
      description:  "Payment for scooter #{@booking.ride.name} for booking #{@booking.id}",
      currency:     @booking.amount.currency
    )

    @booking.update(payment: charge.to_json, state: 'Confirmed')
    redirect_to dashboard_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_booking_payment_path(@booking)
  end

  private

  def booking_exists?
    unless current_user.bookings.where(state: 'Payment pending').where(id: params[:booking_id]).exists?
      redirect_to dashboard_path, alert: 'Sorry, your booking has expired. Your payment has been cancelled.'
    end
  end

  def set_booking
    @booking = current_user.bookings.where(state: 'Payment pending').find(params[:booking_id])
  end
end
