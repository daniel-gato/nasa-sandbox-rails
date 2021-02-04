# frozen_string_literal: true

class ApplicationController < ActionController::API
  def _render
    response.set_header('x-ratelimit-limit', @service[:limit])
    response.set_header('x-ratelimit-remaining', @service[:remaining])
    render json: @service[:data], status: :ok
  end
end
