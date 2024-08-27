class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include Language
  include Pagy::Backend

  def set_locale
    cookies[:locale] = params[:locale]
    redirect_back(fallback_location: root_path)
  end

end
