class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
    @ride = Ride.find(params[:ride_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @ride = Ride.find(params[:ride_id])
    @booking.user_id = current_user.id if current_user
    @booking.ride = @ride
    if @booking.save
      redirect_to ride_path(@ride)
    else
      render 'new'
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
    @booking.destroy
    redirect_to ride_path(@ride)
  end

  private

  def booking_params
    params.require(:booking).permit(:date_begin, :date_end)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
