class FlaresService < ApplicationService
  def initialize(year = nil)
    @year = year || 2020
    # NOTE: the NASA api would default to the last 30 days period
    #       but for simplicity  sake, we will work only with full years
    #       therefore setting this to 2020 by default.
    #       We could use 2021 but as of when I wrote this it was not flare
    #       data for that period.
  end

  def call
    query_cache_or_remote
  end

  def query_cache_or_remote
    Nasa.new.flares(*dates)
  end

  def cache_id; end

  def dates
    return [] if @year.blank?

    [
      "#{@year}-01-01",
      "#{@year}-12-31"
    ]
  end
end
