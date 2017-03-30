class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :set_current_user
  layout :layout_by_resource


  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      "login"
    else
      "application"
    end
  end

  private

    def set_current_user
      User.current = current_user
    end

end
