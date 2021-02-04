class Nasa
  include HTTParty
  base_uri 'https://api.nasa.gov'

  def flares(start_date = nil, end_date = nil)
    get('/DONKI/FLR', startDate: start_date, endDate: end_date)
  end

  def get(service, **kwargs)
    options = { query: { api_key: api_key }.merge(kwargs.compact) }
    ap options
    request = self.class.get(service, options)

    if request.code == 200
      {
        limit: request.headers['x-ratelimit-limit'],
        remaining: request.headers['x-ratelimit-remaining'],
        data: request.parsed_response || []
      }
    else
      raise Exceptions::NasaRequestError, 'Something went wrong'
    end
  end

  def api_key
    @api_key ||= ENV.fetch('NASA_API_KEY')
  end
end
