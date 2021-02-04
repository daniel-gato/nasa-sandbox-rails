# frozen_string_literal: true

class FlareByAttributeService < ApplicationService
  def initialize(attribute, year: nil, filtering: nil)
    @year = year
    @filtering = filtering
    @attribute = attribute
  end

  def call
    flares.merge(data: data)
  end

  def flares
    @flares ||= FlaresService.call(@year)
  end

  def data
    case (@filtering || :list).to_sym
    when :most
      objects.select { |_, value| value == most }.keys.sort
    when :least
      objects.select { |_, value| value == least }.keys.sort
    else
      objects.keys.sort
    end
  end

  def objects
    @objects ||= Hash.new(0).tap do |objects|
      flares[:data].each do |flare|
        next unless (index = flare[@attribute])

        objects[index] += 1
      end
    end
  end

  def most
    objects.values.max
  end

  def least
    objects.values.min
  end
end
