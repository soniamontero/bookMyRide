class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @categories = Ride.pluck(:category).uniq
    set_rides
    calculate_global_rating_index
    @markers = mark_rides_on_map
  end

  def show
    @ride = Ride.find(params[:id])
    @review = Review.new
    @booking = Booking.new
    mark_ride_on_map_show
  end

  def new
    @categories = ['Scooter', 'Custom', 'Motorbike', 'Bicyle', 'Other']
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.user_id = current_user.id if current_user
    if @ride.save
      redirect_to ride_path(@ride)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @ride.update(ride_params)
      redirect_to rides_path(@ride)
    else
      render :edit, alert: 'Something went wrong please try again.'
    end
  end

  def destroy
    @ride = Ride.find(params[:id])
    if @ride.has_upcoming_bookings? == true
      flash[:alert] = "You can't delete that bike. You have upcoming bookings."
      redirect_back(fallback_location: rides_path)
    else
      @ride.destroy
      redirect_back(fallback_location: rides_path)
    end
  end

  private

  def set_rides
    if params[:query].present?
      @rides = Ride.search_by_name_and_location(params[:query])
                   .where.not(latitude: nil, longitude: nil)
      if @rides.empty?
        @rides = Ride.where.not(latitude: nil, longitude: nil)
        @no_location_found = true
      end
    elsif params[:category].present?
      @rides = Ride.where(category: params[:category])
      @rides = Ride.where.not(latitude: nil, longitude: nil) if params[:category] == "Select category"
    else
      @rides = Ride.where.not(latitude: nil, longitude: nil)
    end
  end

  def calculate_global_rating_index
    @rides.each do |ride|
      result = 0
      ratings_number = 0
      ride.reviews.each do |review|
        result += review.rating
        ratings_number += 1
      end
      if ratings_number.positive?
        ride.global_rating = result / ratings_number
        ride.save!
      else
        ride.global_rating = 0
      end
    end
  end

  def mark_ride_on_map_show
    @marker = [{
      lng: @ride.longitude,
      lat: @ride.latitude,
      infoWindow: render_to_string(
        partial: 'infowindow', locals: { ride: @ride }
      )
    }]
  end

  def mark_rides_on_map
    @markers = @rides.map do |ride|
      {
        lng: ride.longitude,
        lat: ride.latitude,
        infoWindow: render_to_string(
          partial: 'infowindow', locals: { ride: ride }
        )
      }
    end
    @markers
  end

  def ride_params
    params.require(:ride).permit(:name, :year, :price, :description, :category,
                                 :location, :global_rating, :photo)
  end

  def set_ride
    @ride = Ride.find(params[:id])
  end
end
