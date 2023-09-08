# frozen_string_literal: true

require "jsonapi-realizer"
require "jsonapi-serializers"
require "array-where"

module JSONAPI
  MEDIA_TYPE = "application/vnd.api+json" unless const_defined?(:MEDIA_TYPE)

  module Home
    extend ActiveSupport::Concern

    DEFAULT_DESCRIPTION = "A JSON:API resource as defined at https://www.jsonapi.org"

    require_relative "home/inflector"
    require_relative "home/engine"

    class_methods do
      # rubocop:disable Metrics/ParameterLists
      def discoverable(version:, namespace:, deprecated: nil, description: DEFAULT_DESCRIPTION, documentation: nil, location: nil, jsonapi_version: "1.0")
        instance_variable_set(:@jsonapi_home_endpoint, {
                                location:,
                                description:,
                                deprecated:,
                                documentation:,
                                jsonapi_version:,
                                version:,
                                namespace:
                              })
      end
      # rubocop:enable Metrics/ParameterLists
    end
  end
end
