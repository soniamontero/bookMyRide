class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home; end

  def policy; end

  def user_dashboard
    @user = current_user
  end

  def rental_dashboard
    @user = current_user
  end
end
