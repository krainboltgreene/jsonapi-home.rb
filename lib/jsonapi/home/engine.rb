module JSONAPI
  module Home
    class Engine < Rails::Engine
      isolate_namespace JSONAPI::Home
    end
  end
end
