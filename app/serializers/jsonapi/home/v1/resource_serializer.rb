# frozen_string_literal: true

module JSONAPI
  module Home
    module V1
      class ResourceSerializer
        include JSONAPI::Serializer

        attribute :namespace
        attribute :version
        attribute :intent
        attribute :description
        attribute :deprecated
        attribute :verb
        attribute :href
        attribute :mediatype
        attribute :created_at
        attribute :updated_at

        def type
          "jsonapi-home-resources"
        end

        def jsonapi
          {
            version: object.jsonapi_version
          }
        end

        def meta
          [
            if object.documentation
              {
                documentation: {
                  href: object.documentation
                }
              }
            end
          ].compact.reduce(&:merge)
        end
      end
    end
  end
end
