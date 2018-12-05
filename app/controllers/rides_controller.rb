class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @rides = Ride.all
  end

  def show
    calculate_global_rating
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
      @ride.photos.attach(params["ride"]["photos"])
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

  def calculate_global_rating
    result = 0
    ratings_number = 0
    @ride.reviews.each do |review|
      result += review.rating
      ratings_number += 1
    end
    if ratings_number > 0
      @ride.global_rating = result / ratings_number
    else
      @ride.global_rating = 0
    end
  end

  def ride_params
    params.require(:ride).permit(:name, :year, :price, :category, :location, photos: [])
  end

  def set_ride
    @ride = Ride.find(params[:id])
  end
end
