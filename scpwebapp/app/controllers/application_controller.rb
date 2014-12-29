class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale
  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    def admin_user
      @admin_user ||= true if @current_user.role.value.to_i == 1
    end
  
    def technician_user
      @technician_user ||= true if @current_user.role.value.to_i == 2
    end
  
    def set_locale
      I18n.locale = session[:locale] || I18n.default_locale
      session[:locale] = I18n.locale
    end
    helper_method :current_user, :admin_user, :technician_user
end
