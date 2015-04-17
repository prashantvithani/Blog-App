class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_filter :update_sanitized_params_signup, if: :devise_controller?
  before_filter :update_sanitized_params_edit, if: :devise_controller?
  before_filter :set_cache_buster
  after_filter :store_location

	def store_location
	  # store last url - this is needed for post-login redirect to whatever the user last visited.
	  return unless request.get? 
	  if (request.path != "/users/sign_in" &&
	      request.path != "/users/sign_up" &&
	      request.path != "/users/password/new" &&
	      request.path != "/users/password/edit" &&
	      request.path != "/users/confirmation" &&
	      request.path != "/users/sign_out" &&
	      !request.xhr?) # don't store ajax calls
	    session[:previous_url] = request.fullpath 
	  end
	end

	def after_sign_in_path_for(resource)
	  session[:previous_url] || root_path
	end

  	def update_sanitized_params_signup
		devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :full_name, :gender)}
	end

	def update_sanitized_params_edit
		devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :current_password, :full_name, :gender)}
	end

	def set_cache_buster
	    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
	    response.headers["Pragma"] = "no-cache"
	    response.headers["Expires"] = "#{1.year.ago}"
  	end
end
