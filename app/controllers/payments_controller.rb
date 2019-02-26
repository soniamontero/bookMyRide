class PaymentsController < ApplicationController
   before_action :set_booking

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @booking.amount_cents,
      description:  "Payment for scooter #{@booking.ride.name} for booking #{@booking.id}",
      currency:     @booking.amount.currency
    )

    @booking.update(payment: charge.to_json, state: 'paid')
    redirect_to dashboard_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_booking_payment_path(@booking)
  end

  private

  def set_booking
    @booking = current_user.bookings.where(state: 'pending').find(params[:booking_id])
  end
end
