class ApplicationController < ActionController::API
  def _render
    response.set_header('x-ratelimit-limit', @service[:limit])
    response.set_header('x-ratelimit-remaining', @service[:remaining])
    response.set_header('x-cached', @service[:cached])
    render json: @service[:data], status: :ok
  end
end
