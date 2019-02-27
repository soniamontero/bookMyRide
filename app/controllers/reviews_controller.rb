class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @ride = Ride.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @ride = Ride.find(params[:ride_id])
    @review.ride_id = @ride.id
    @review.user_id = current_user.id
    if @review.save
       respond_to do |format|
        format.js  # <-- will render `app/views/reviews/create.js.erb`
        format.html { redirect_to ride_path(@ride) }
      end
    else
      respond_to do |format|
        format.html { render 'rides/show' }
        format.js  # <-- idem
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :message, :rating)
  end
end
