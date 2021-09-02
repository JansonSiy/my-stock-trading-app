class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # permit to add additional parameters
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
          user_params.permit(:role, :credit)
      end
  end
end
