class ApplicationController < ActionController::Base
	before_action :store_current_location, :unless => :devise_controller?

# Rodar Pundit em todas minhas aplicações
	include Pundit

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Set Layout
  layout :layout_by_resource

	protected

	def layout_by_resource
	  if devise_controller? && resource_name == :admin
	    "backoffice_devise"
		elsif devise_controller? && resource_name == :member
			"site_devise"
	  else
	    "application"
	  end
	end

	def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

	private
  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:member, request.url)
  end
end
