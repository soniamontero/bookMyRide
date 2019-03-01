  class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = current_user.bookings.where(state: 'Confirmed').find(params[:id])
  end

  def new
  end

  # order  = Order.create!(teddy_sku: teddy.sku, amount: teddy.price, state: 'pending', user: current_user)

  def create
    @booking = Booking.new(booking_params)
    @ride = Ride.find(params[:ride_id])
    @booking.user_id = current_user.id if current_user
    @booking.ride = @ride
    amount = calculate_price(@booking.date_begin, @booking.date_end, @booking.ride.price)
    @booking.amount_cents = amount
    @booking.state = 'Payment pending'
    if @booking.save
      redirect_to new_ride_booking_payment_path(@ride, @booking)
    else
      redirect_to ride_path(@ride)
    end
  end

  def edit
    @ride = Ride.find(params[:ride_id])
  end

  def update
    @ride = Ride.find(params[:ride_id])
    if @booking.update(booking_params)
      redirect_to ride_path(@ride)
    else
      render 'edit', alert: "Something went wrong."
    end
  end

  def destroy
    @ride = Ride.find(params[:ride_id])
    if @booking.destroy
      redirect_to ride_path(@ride)
    end
  end

  private

  def calculate_price(date_begin, date_end, price_unprocessed)
    price = price_unprocessed.fractional
    number_of_days = (date_end.to_date - date_begin.to_date).to_i
    if number_of_days == 0
      amount = price
    else
      amount = number_of_days * price
    end
    amount
  end

  def booking_params
    params.require(:booking).permit(:date_begin, :date_end, :state, :amount_cents)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
