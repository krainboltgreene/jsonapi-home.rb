require "jsonapi-realizer"
require "jsonapi-serializers"
require "array-where"

module JSONAPI
  MEDIA_TYPE = "application/vnd.api+json" unless const_defined?("MEDIA_TYPE")

  module Home
    extend ActiveSupport::Concern

    DEFAULT_DESCRIPTION = "A JSON:API resource as defined at https://www.jsonapi.org"

    require_relative "home/inflector"
    require_relative "home/engine"

    class_methods do
      def discoverable(version:, namespace:, deprecated: nil, description: DEFAULT_DESCRIPTION, documentation: nil, location: nil, jsonapi_version: "1.0")
        instance_variable_set(:@jsonapi_home_endpoint, {
          location: location,
          description: description,
          deprecated: deprecated,
          documentation: documentation,
          jsonapi_version: jsonapi_version,
          version: version,
          namespace: namespace
        })
      end
    end
  end
end
