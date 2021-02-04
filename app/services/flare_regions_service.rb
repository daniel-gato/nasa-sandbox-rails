class FlareRegionsService < FlareByAttributeService
  def initialize(**kwargs)
    super('activeRegionNum', **kwargs)
  end
end
