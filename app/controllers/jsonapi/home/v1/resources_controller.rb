# frozen_string_literal: true

module JSONAPI
  module Home
    module V1
      class ResourcesController < ::ApplicationController
        include JSONAPI::Home

        discoverable(
          version: "v1",
          namespace: "jsonapi-home-resources",
          description: "All discoverable HTTP JSON:API endpoints that this server knows about",
          documentation: "https://github.com/krainboltgreene/jsonapi-home.rb"
        )

        def index
          realization = JSONAPI::Realizer.index(
            params,
            headers: request.headers,
            type: :jsonapi_home_resources
          )

          render json: serialize(realization)
        end

        def show
          realization = JSONAPI::Realizer.show(
            params,
            headers: request.headers,
            type: :jsonapi_home_resources
          )

          render json: serialize(realization)
        end

        private def serialize(realization)
          JSONAPI::Serializer.serialize(
            realization.respond_to?(:models) ? realization.models : realization.model,
            is_collection: realization.respond_to?(:models),
            meta: serialized_metadata,
            links: serialized_links,
            jsonapi: serialized_jsonapi,
            fields: (realization.fields if realization.fields.any?),
            include: (realization.includes if realization.includes.any?)
          )
        end

        private def serialized_metadata
          {
            endpoint: {
              version: "1"
            }
          }
        end

        private def serialized_links
          [
            if instance_variable_get(:@jsonapi_home_location)
              {
                home: {
                  href: "#{instance_variable_get(:@jsonapi_home_location)}/jsonapi-home-resources"
                }
              }
            end,
            if ENV.key?("HOME_DOCUMENTATION_HREF")
              {
                documentation: {
                  href: ENV.fetch("HOME_DOCUMENTATION_HREF").to_s
                }
              }
            end
          ].compact.reduce(&:merge)
        end

        private def serialized_jsonapi
          {
            version: "1.0"
          }
        end
      end
    end
  end
end
