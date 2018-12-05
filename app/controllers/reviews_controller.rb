class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @ride = Ride.find(params[:ride_id])
  end

  def create
    @review = Review.new(review_params)
    @ride = Ride.find(params[:ride_id])
    @review.ride_id = @ride.id
    @review.user_id = current_user.id
    @review.save
    redirect_to ride_path(@ride)
  end

  private

  def review_params
    params.require(:review).permit(:title, :message, :rating)
  end
end
