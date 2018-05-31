module JSONAPI
  module Home
    module V1
      class Resource
        include ActiveModel::Model

        CREATED_AT = Time.now
        private_constant :CREATED_AT

        attr_accessor :route
        private :route

        def self.all
          routes.map {|route| new(route: route)}.select(&:valid?)
        end

        def self.where(attributes)
          all.where(attributes)
        end

        def self.fetch(id)
          all.index_by(&:id).fetch(id)
        end

        def self.with(url)
          tap { @url = url }
        end

        def self.url
          @url
        end

        private_class_method def self.routes
          [
            *Rails.application.routes.routes.to_a,
            *Rails::Engine.subclasses.map(&:instance).map(&:routes).map(&:routes).map(&:to_a).flatten
          ]
        end

        def id
          "#{namespace}-#{version}-#{intent}"
        end

        def intent
          defaults.fetch(:action)
        end

        def namespace
          configuration.fetch(:namespace)
        end

        def version
          configuration.fetch(:version)
        end

        def description
          configuration.fetch(:description)
        end

        def deprecated
          if configuration.fetch(:deprecated).respond_to?(:fetch)
            configuration.fetch(:deprecated).fetch(action, nil)
          else
            configuration.fetch(:deprecated)
          end
        end

        def documentation
          configuration.fetch(:documentation)
        end

        def jsonapi_version
          configuration.fetch(:version)
        end

        def verb
          route.verb
        end

        def href
          File.join(location, path)
        end

        def mediatype
          JSONAPI::MEDIA_TYPE
        end

        def created_at
          CREATED_AT
        end

        def updated_at
          Time.now
        end

        def valid?
          !route.internal && defaults.any? && controller.present? && configuration
        end

        private def location
          configuration.fetch(:location) ||
          ENV.fetch("HOME_LOCATION", nil) ||
          self.class.url
        end

        private def payload
          route.parts.without(:format).map {|part| {part => "{#{part}}"}}.reduce(:merge) || {}
        end

        private def path
          URI.decode(route.format(payload))
        end

        private def controller
          controller_name.constantize
        rescue NameError => exception
          Rails.logger.debug("jsonapi-home saw a route and tried to find #{controller_name}")
        end

        private def action
          defaults.fetch(:action)
        end

        private def controller_name
          "#{defaults.fetch(:controller).classify.pluralize}Controller"
        end

        private def defaults
          route.defaults
        end

        private def configuration
          controller.instance_variable_get(:@jsonapi_home_endpoint)
        end
      end
    end
  end
end
