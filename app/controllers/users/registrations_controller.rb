# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_resource, except: [:new, :create]

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.mailer_created.deliver_later
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end
end