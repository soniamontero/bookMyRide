class ReviewsController < ApplicationController
  def new
    @ride = Ride.find(params[:ride_id])
    @booking = Booking.find(params[:booking_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @booking = Booking.find(params[:booking_id])
    @review.booking_id = @booking.id
    @ride = @booking.ride
    if @review.save
      redirect_to ride_path(@ride)
    else
      redirect_to rides_path ## TO UPDATE
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :message, :rating, :booking_id)
  end
end
