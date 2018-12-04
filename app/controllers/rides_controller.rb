class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @rides = Ride.all
  end

  def show
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
      render :new, alert: 'Something went wrong please try again.'
    end
  end

  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy
    redirect_to rides_path
  end

  private

  def ride_params
    params.require(:ride).permit(:name, :year, :price, :category)
  end

  def set_ride
    @ride = Ride.find(params[:id])
  end
end
