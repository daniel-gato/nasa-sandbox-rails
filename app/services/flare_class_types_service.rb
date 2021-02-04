# frozen_string_literal: true

class FlareClassTypesService < FlareByAttributeService
  def initialize(**kwargs)
    super('classType', **kwargs)
  end
end
