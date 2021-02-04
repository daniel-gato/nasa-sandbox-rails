# frozen_string_literal: true

class FlareRegionsService < FlareByAttributeService
  def initialize(**kwargs)
    super('activeRegionNum', **kwargs)
  end
end
