class ApplicationController < ActionController::Base
  require 'end_user_sanitizer'
  
  protected

  def devise_parameter_sanitizer
    if resource_class == EndUser
      EndUserParameterSanitizer.new(EndUser, :end_user, params)
    else
      super
    end
  end
end
