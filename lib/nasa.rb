# frozen_string_literal: true

class Nasa
  include HTTParty
  base_uri 'https://api.nasa.gov'

  def flares(start_date = nil, end_date = nil)
    fetch('/DONKI/FLR', startDate: start_date, endDate: end_date)
  end

  def fetch(service, **kwargs)
    options = { query: { api_key: api_key }.merge(kwargs.compact) }
    key = cache_key(service, options)

    Rails.cache.fetch(key, expires_in: 5.minutes) do
      remote(service, options)
    end
  end

  def remote(service, options)
    request = self.class.get(service, options)

    raise Exceptions::NasaRequestError unless request.code == 200

    {
      limit: request.headers['x-ratelimit-limit'],
      remaining: request.headers['x-ratelimit-remaining'],
      data: request.parsed_response || []
    }
  end

  def api_key
    @api_key ||= ENV.fetch('NASA_API_KEY')
  end

  def cache_key(*args)
    Digest::MD5.hexdigest(args.join('-'))
  end
end
