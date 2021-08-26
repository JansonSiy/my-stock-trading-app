class Admins::DashboardController < ApplicationController
  def index
    @users = User.all
  end
end