class FlaresController < ApplicationController
  def index
    @service = FlaresService.call(year)
    _render
  end

  def regions
    @service = FlareRegionsService.call(year: year, filtering: filtering)
    _render
  end

  def class_types
    @service = FlareClassTypesService.call(year: year, filtering: filtering)
    _render
  end

  def _render
    response.set_header('x-ratelimit-limit', @service[:limit])
    response.set_header('x-ratelimit-remaining', @service[:remaining])
    response.set_header('x-cached', @service[:cached])
    render json: @service[:data], status: :ok
  end

  def year
    params[:year]
  end

  def filtering
    params[:filtering]
  end
end
