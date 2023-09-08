# frozen_string_literal: true

module JSONAPI
  module Home
    module V1
      class ResourceRealizer
        include JSONAPI::Realizer::Resource

        register :jsonapi_home_resources, class_name: "JSONAPI::Home::V1::Resource", adapter: :memory

        has :namespace
        has :version
        has :intent
        has :verb
        has :href
        has :deprecated
        has :mediatype
        has :description
        has :created_at
        has :updated_at
      end
    end
  end
end
