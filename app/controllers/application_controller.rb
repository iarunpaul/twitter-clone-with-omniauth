class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  # def restrict_api
  #   api_key = ApiKey.find_by_access_token(params[:access_token])
  #   head :unauthorized unless api_key
  #   # render :file => "public/404", :status => :unauthorized
  # end

  def restrict_api
    authenticate_or_request_with_http_token do |token, options|
    ApiKey.exists?(access_token: token)
    end
  end
end
