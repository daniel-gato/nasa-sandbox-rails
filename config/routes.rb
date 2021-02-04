# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :flares do
    get '/regions/:year/:filtering', action: :regions
    get '/regions/:year', action: :regions
    get '/regions', action: :regions
    get '/class_types/:year/:filtering', action: :class_types
    get '/class_types/:year', action: :class_types
    get '/class_types', action: :class_types
    get '/:year', action: :index
    get '/', action: :index
  end
end
