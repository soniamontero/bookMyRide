class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # if params[:query].present?
    #    sql_query = "name ILIKE :query OR location ILIKE :query"
    #   @rides = Ride.where(sql_query, query: "%#{params[:query]}%")
    #                .where.not(latitude: nil, longitude: nil)
    # else
    #   @rides = Ride.where.not(latitude: nil, longitude: nil)
    # end
    if params[:query].present?
      @rides = Ride.search_by_name_and_location("Canggu")
                   .where.not(latitude: nil, longitude: nil)
    else
      @rides = Ride.where.not(latitude: nil, longitude: nil)
    end
    calculate_global_rating_index
    mark_rides_on_map
  end

  def show
    @ride = Ride.find(params[:id])
    @review = Review.new
  end

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.user_id = current_user.id if current_user
    if @ride.save
      redirect_to rides_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @ride.update(ride_params)
      redirect_to rides_path(@ride)
    else
      render :edit, alert: 'Something went wrong please try again.'
    end
  end

  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy
    redirect_to rides_path
  end

  private

  def calculate_global_rating_index
    @rides.each do |ride|
      result = 0
      ratings_number = 0
        ride.reviews.each do |review|
        result += review.rating
        ratings_number += 1
      end
      if ratings_number > 0
        ride.global_rating = result / ratings_number
        ride.save!
      else
        ride.global_rating = 0
      end
    end
  end

  def mark_rides_on_map
    @markers = @rides.map do |flat|
      {
        lng: flat.longitude,
        lat: flat.latitude
      }
    end
  end

  def ride_params
    params.require(:ride).permit(:name, :year, :price, :category, :location, :global_rating, photos: [])
  end

  def set_ride
    @ride = Ride.find(params[:id])
  end
end
