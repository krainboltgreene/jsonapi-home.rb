module V1
  class PostsController < V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "posts",
      description: "Oh hi, mark",
      documentation: "https://www.schema.org",
      location: "https://www.example.com",
      jsonapi_version: "1.1",
      deprecated: {
        index: true
      }
    )
  end
end
