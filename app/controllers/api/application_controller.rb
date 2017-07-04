class Api::ApplicationController < ActionController::API
  include Api::AuthenticationHelper

  before_action :validate_http_origin

  ACCESS_CONTROL_ALLOW_METHODS = %w(GET OPTIONS).freeze
  ACCESS_CONTROL_ALLOW_HEADERS = %w(Accept Origin Content-Type Authorization).freeze
  ACCESS_CONTROL_MAX_AGE = 86400

  def preflight
    return render nothing: true, status: :not_found if request.headers['HTTP_ORIGIN'].blank?

    set_preflight_headers!
    head :ok
  end

  private

  def validate_http_origin
    request_origin = request.headers['HTTP_ORIGIN']
    return if request_origin.blank?   # 通常のリクエストであれば何もしない

    if request_origin == 'http://localhost:3000'
      response.headers['Access-Control-Allow-Origin'] = request_origin
    else
      render nothing: true, status: :not_acceptable
    end
  end

  def set_preflight_headers!
    response.headers['Access-Control-Max-Age'] = ACCESS_CONTROL_MAX_AGE
    response.headers['Access-Control-Allow-Headers'] = ACCESS_CONTROL_ALLOW_HEADERS.join(',')
    response.headers['Access-Control-Allow-Methods'] = ACCESS_CONTROL_ALLOW_METHODS.join(',')
  end
end
