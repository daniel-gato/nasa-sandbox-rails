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

  def year
    params[:year]
  end

  def filtering
    params[:filtering]
  end
end
