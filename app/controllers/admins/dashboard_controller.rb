class Admins::DashboardController < ApplicationController
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(:approved=>true)

    redirect_to admins_authenticated_root_path(@user), notice: "user was successfully approved."
    # finding the user/id and updating it to boolean value" true
  end

end