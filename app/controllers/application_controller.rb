class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    dashboard_index_path # or specify another path
  end

  # Redirect after sign-up
  def after_sign_up_path_for(resource)
    dashboard_index_path # or specify another path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :picture])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :picture ])
  end
end
