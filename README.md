# jsonapi-home

  - [![Build](http://img.shields.io/travis-ci/krainboltgreene/jsonapi-home.rb.svg?style=flat-square)](https://travis-ci.org/krainboltgreene/jsonapi-home)
  - [![Downloads](http://img.shields.io/gem/dtv/jsonapi-home.svg?style=flat-square)](https://rubygems.org/gems/jsonapi-home)
  - [![Version](http://img.shields.io/gem/v/jsonapi-home.svg?style=flat-square)](https://rubygems.org/gems/jsonapi-home)

An implementation of an experimental JSON:API-Home specification, which is a combination of the [JSONHome](https://tools.ietf.org/html/draft-nottingham-json-home-06) and [json:api](https://www.jsonapi.org).


## Using

To start lets mount the engine:

``` ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount JSONAPI::Home::Engine, at: "/"

  namespace :v1 do
    resources :accounts
  end

  root to: "pages#landing"
end
```

This will setup the basic set of home routes and with the following request:

```
* Preparing request to http://localhost:3000/v1/jsonapi-home-resources
* Using libcurl/7.54.0 SecureTransport zlib/1.2.8
* Enable automatic URL encoding
* Enable SSL validation
* Enable cookie sending with jar of 0 cookies
* Connection 68 seems to be dead!
* Closing connection 68
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 3000 (#69)
> GET /v1/jsonapi-home-resources HTTP/1.1
> Host: localhost:3000
> User-Agent: insomnia/5.14.9
> Accept: application/vnd.api+json
< HTTP/1.1 200 OK
< Content-Type: application/json; charset=utf-8
< Etag: W/"dfafe86e832bea875149e878c0616b96"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: 942ba1cd-2bbc-4902-a89a-8706da7d5533
< X-Runtime: 0.037835
< Server: WEBrick/1.4.2 (Ruby/2.5.0/2017-12-25)
< Date: Sun, 25 Mar 2018 23:07:05 GMT
< Content-Length: 1194
< Connection: Keep-Alive

* Received 1194 B chunk
* Connection #69 to host localhost left intact
```

You'll get this payload:

``` json
{
  "data": [
    {
      "type": "jsonapi-home-resources",
      "id": "jsonapi-home-resources-v1-index",
      "attributes": {
        "namespace": "jsonapi-home-resources",
        "version": "v1",
        "intent": "index",
        "description": "All discoverable HTTP JSON:API endpoints that this server knows about",
        "verb": "GET",
        "href": "/v1/jsonapi-home-resources",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-25T16:07:03.039-07:00",
        "updated-at": "2018-03-25T16:07:05.000-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/jsonapi-home-resources-v1-index"
      },
      "jsonapi": {
        "version": "1.0"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "jsonapi-home-resources-v1-show",
      "attributes": {
        "namespace": "jsonapi-home-resources",
        "version": "v1",
        "intent": "show",
        "description": "All discoverable HTTP JSON:API endpoints that this server knows about",
        "verb": "GET",
        "href": "/v1/jsonapi-home-resources/{id}",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-25T16:07:03.039-07:00",
        "updated-at": "2018-03-25T16:07:05.003-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/jsonapi-home-resources-v1-show"
      },
      "jsonapi": {
        "version": "1.0"
      }
    }
  ],
  "jsonapi": {
    "version": "1.0"
  },
  "meta": {
    "endpoint": {
      "version": "1"
    }
  }
}
```

You'll notice that we only show our own home routes, we're self-referential! Now we've got to setup your other endpoints:

``` ruby
module V1
  class AccountsController < V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "accounts"
    )

    def index
      # ...
    end

    def show
      # ...
    end

    def create
      # ...
    end

    def update
      # ...
    end

    def destroy
      # ...
    end
  end
end
```

Which results in this payload:

```
* Preparing request to http://localhost:3000/v1/jsonapi-home-resources
* Using libcurl/7.54.0 SecureTransport zlib/1.2.8
* Enable automatic URL encoding
* Enable SSL validation
* Enable cookie sending with jar of 0 cookies
* Connection 69 seems to be dead!
* Closing connection 69
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 3000 (#70)
> GET /v1/jsonapi-home-resources HTTP/1.1
> Host: localhost:3000
> User-Agent: insomnia/5.14.9
> Accept: application/vnd.api+json
< HTTP/1.1 200 OK
< Content-Type: application/json; charset=utf-8
< Etag: W/"4a0ff42059f174ee886ec63b3edeac30"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: 3afadc55-ed06-4811-8500-939dee3271bd
< X-Runtime: 0.125346
< Server: WEBrick/1.4.2 (Ruby/2.5.0/2017-12-25)
< Date: Mon, 26 Mar 2018 01:28:41 GMT
< Content-Length: 5591
< Connection: Keep-Alive

* Received 5.5 KB chunk
* Connection #70 to host localhost left intact
```

``` json
{
  "data": [
    {
      "type": "jsonapi-home-resources",
      "id": "accounts-v1-index",
      "attributes": {
        "namespace": "accounts",
        "version": "v1",
        "intent": "index",
        "description": "A JSON:API resource as defined at https://www.jsonapi.org",
        "deprecated": null,
        "verb": "GET",
        "href": "/v1/accounts",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.023-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/accounts-v1-index"
      },
      "jsonapi": {
        "version": "v1"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "accounts-v1-create",
      "attributes": {
        "namespace": "accounts",
        "version": "v1",
        "intent": "create",
        "description": "A JSON:API resource as defined at https://www.jsonapi.org",
        "deprecated": null,
        "verb": "POST",
        "href": "/v1/accounts",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.038-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/accounts-v1-create"
      },
      "jsonapi": {
        "version": "v1"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "accounts-v1-new",
      "attributes": {
        "namespace": "accounts",
        "version": "v1",
        "intent": "new",
        "description": "A JSON:API resource as defined at https://www.jsonapi.org",
        "deprecated": null,
        "verb": "GET",
        "href": "/v1/accounts/new",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.056-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/accounts-v1-new"
      },
      "jsonapi": {
        "version": "v1"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "accounts-v1-edit",
      "attributes": {
        "namespace": "accounts",
        "version": "v1",
        "intent": "edit",
        "description": "A JSON:API resource as defined at https://www.jsonapi.org",
        "deprecated": null,
        "verb": "GET",
        "href": "/v1/accounts/{id}/edit",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.067-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/accounts-v1-edit"
      },
      "jsonapi": {
        "version": "v1"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "accounts-v1-show",
      "attributes": {
        "namespace": "accounts",
        "version": "v1",
        "intent": "show",
        "description": "A JSON:API resource as defined at https://www.jsonapi.org",
        "deprecated": null,
        "verb": "GET",
        "href": "/v1/accounts/{id}",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.073-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/accounts-v1-show"
      },
      "jsonapi": {
        "version": "v1"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "accounts-v1-update",
      "attributes": {
        "namespace": "accounts",
        "version": "v1",
        "intent": "update",
        "description": "A JSON:API resource as defined at https://www.jsonapi.org",
        "deprecated": null,
        "verb": "PATCH",
        "href": "/v1/accounts/{id}",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.076-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/accounts-v1-update"
      },
      "jsonapi": {
        "version": "v1"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "accounts-v1-update",
      "attributes": {
        "namespace": "accounts",
        "version": "v1",
        "intent": "update",
        "description": "A JSON:API resource as defined at https://www.jsonapi.org",
        "deprecated": null,
        "verb": "PUT",
        "href": "/v1/accounts/{id}",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.080-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/accounts-v1-update"
      },
      "jsonapi": {
        "version": "v1"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "accounts-v1-destroy",
      "attributes": {
        "namespace": "accounts",
        "version": "v1",
        "intent": "destroy",
        "description": "A JSON:API resource as defined at https://www.jsonapi.org",
        "deprecated": null,
        "verb": "DELETE",
        "href": "/v1/accounts/{id}",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.083-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/accounts-v1-destroy"
      },
      "jsonapi": {
        "version": "v1"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "posts-v1-index",
      "attributes": {
        "namespace": "posts",
        "version": "v1",
        "intent": "index",
        "description": "Oh hi, mark",
        "deprecated": false,
        "verb": "GET",
        "href": "https://www.example.com/v1/posts",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.088-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/posts-v1-index"
      },
      "jsonapi": {
        "version": "v1"
      },
      "meta": {
        "documentation": {
          "href": "https://www.schema.org"
        }
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "posts-v1-update",
      "attributes": {
        "namespace": "posts",
        "version": "v1",
        "intent": "update",
        "description": "Oh hi, mark",
        "deprecated": false,
        "verb": "PATCH",
        "href": "https://www.example.com/v1/posts/{id}",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.093-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/posts-v1-update"
      },
      "jsonapi": {
        "version": "v1"
      },
      "meta": {
        "documentation": {
          "href": "https://www.schema.org"
        }
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "posts-v1-update",
      "attributes": {
        "namespace": "posts",
        "version": "v1",
        "intent": "update",
        "description": "Oh hi, mark",
        "deprecated": false,
        "verb": "PUT",
        "href": "https://www.example.com/v1/posts/{id}",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.097-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/posts-v1-update"
      },
      "jsonapi": {
        "version": "v1"
      },
      "meta": {
        "documentation": {
          "href": "https://www.schema.org"
        }
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "posts-v1-destroy",
      "attributes": {
        "namespace": "posts",
        "version": "v1",
        "intent": "destroy",
        "description": "Oh hi, mark",
        "deprecated": false,
        "verb": "DELETE",
        "href": "https://www.example.com/v1/posts/{id}",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.101-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/posts-v1-destroy"
      },
      "jsonapi": {
        "version": "v1"
      },
      "meta": {
        "documentation": {
          "href": "https://www.schema.org"
        }
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "accounts-v1-index",
      "attributes": {
        "namespace": "accounts",
        "version": "v1",
        "intent": "index",
        "description": "A JSON:API resource as defined at https://www.jsonapi.org",
        "deprecated": null,
        "verb": "GET",
        "href": "/",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.108-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/accounts-v1-index"
      },
      "jsonapi": {
        "version": "v1"
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "jsonapi-home-resources-v1-index",
      "attributes": {
        "namespace": "jsonapi-home-resources",
        "version": "v1",
        "intent": "index",
        "description": "All discoverable HTTP JSON:API endpoints that this server knows about",
        "deprecated": null,
        "verb": "GET",
        "href": "/v1/jsonapi-home-resources",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.111-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/jsonapi-home-resources-v1-index"
      },
      "jsonapi": {
        "version": "v1"
      },
      "meta": {
        "documentation": {
          "href": "https://github.com/krainboltgreene/jsonapi-home.rb"
        }
      }
    },
    {
      "type": "jsonapi-home-resources",
      "id": "jsonapi-home-resources-v1-show",
      "attributes": {
        "namespace": "jsonapi-home-resources",
        "version": "v1",
        "intent": "show",
        "description": "All discoverable HTTP JSON:API endpoints that this server knows about",
        "deprecated": null,
        "verb": "GET",
        "href": "/v1/jsonapi-home-resources/{id}",
        "mediatype": "application/vnd.api+json",
        "created-at": "2018-03-26T00:17:28.693-07:00",
        "updated-at": "2018-03-26T00:17:31.115-07:00"
      },
      "links": {
        "self": "/jsonapi-home-resources/jsonapi-home-resources-v1-show"
      },
      "jsonapi": {
        "version": "v1"
      },
      "meta": {
        "documentation": {
          "href": "https://github.com/krainboltgreene/jsonapi-home.rb"
        }
      }
    }
  ],
  "jsonapi": {
    "version": "1.0"
  },
  "meta": {
    "endpoint": {
      "version": "1"
    }
  }
}
```

You can also inquire about individual endpoints:

```
* Preparing request to http://localhost:3000/v1/jsonapi-home-resources/accounts-v1-destroy
* Using libcurl/7.54.0 SecureTransport zlib/1.2.8
* Enable automatic URL encoding
* Enable SSL validation
* Enable cookie sending with jar of 0 cookies
* Connection 70 seems to be dead!
* Closing connection 70
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 3000 (#71)
> GET /v1/jsonapi-home-resources/accounts-v1-destroy HTTP/1.1
> Host: localhost:3000
> User-Agent: insomnia/5.14.9
> Accept: application/vnd.api+json
< HTTP/1.1 200 OK
< Content-Type: application/json; charset=utf-8
< Etag: W/"ea14613f3daa0a8e2edfff922d88ef95"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: d16732df-3f7f-434b-a4da-d08b7ab27ee6
< X-Runtime: 0.022813
< Server: WEBrick/1.4.2 (Ruby/2.5.0/2017-12-25)
< Date: Mon, 26 Mar 2018 01:31:12 GMT
< Content-Length: 571
< Connection: Keep-Alive

* Received 571 B chunk
* Connection #71 to host localhost left intact
```

``` json
{
  "data": {
    "type": "jsonapi-home-resources",
    "id": "accounts-v1-destroy",
    "attributes": {
      "namespace": "accounts",
      "version": "v1",
      "intent": "destroy",
      "description": "A JSON:API resource as defined at https://www.jsonapi.org",
      "verb": "DELETE",
      "href": "/v1/accounts/{id}",
      "mediatype": "application/vnd.api+json",
      "created-at": "2018-03-25T18:28:37.776-07:00",
      "updated-at": "2018-03-25T18:31:12.294-07:00"
    },
    "links": {
      "self": "/jsonapi-home-resources/accounts-v1-destroy"
    },
    "jsonapi": {
      "version": "1.0"
    }
  },
  "jsonapi": {
    "version": "1.0"
  },
  "meta": {
    "endpoint": {
      "version": "1"
    }
  }
}
```

Because it's jsonapi.org you can use all the normal interfaces.

### Custom URL Location

**By default you will see resources have a root url of whatever returns from `root_path`.**

If you need a different value you can do one of two things:

  - You can set up a `HOME_LOCATION` ENV variable which is a protocol+hostname[+suffix] combination where your endpoints exist:
  ```
  HOME_LOCATION=https://origin.example.com
  ```
  - If you need an individual endpoint to have this value, try:
  ``` ruby
  module V1
    class AccountsController < V1::ApplicationController
      discoverable(
        version: "v1",
        namespace: "accounts",
        location: "http://special.example.com"
      )
    end
  end
  ```

### Custom Description

If you want you can overwrite the description that comes with every endpoint to provide context:

``` ruby
module V1
  class AccountsController < V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "accounts",
      description: "The accounts resource is being removed on the 5th of march"
    )
  end
end
```

### Deprecated

To provide a hint to clients you can also set the entire endpoint as deprecated:

``` ruby
module V1
  class AccountsController < V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "accounts",
      deprecated: true,
    )
  end
end
```

Or specific endpoints:

``` ruby
module V1
  class AccountsController < V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "accounts",
      deprecated: {
        index: true
      },
    )
  end
end
```

### Documentation HREF

Every endpoint can link to the human documentation for that endpoint:

``` ruby
module V1
  class AccountsController < V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "accounts",
      documentation: "https://documentation.example.com"
    )
  end
end
```

### JSONAPI Version

Finally you can specify the specific version of JSON:API this endpoint uses:

``` ruby
module V1
  class AccountsController < V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "accounts",
      jsonapi_version: "1.1"
    )
  end
end
```

Of course, these are all just descriptive. jsonapi-home does not enforce these configurations.

## Installing

Add this line to your application's Gemfile:

    gem "jsonapi-home", "1.0.0"

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install jsonapi-home


## Contributing

  1. Read the [Code of Conduct](/CONDUCT.md)
  2. Fork it
  3. Create your feature branch (`git checkout -b my-new-feature`)
  4. Commit your changes (`git commit -am 'Add some feature'`)
  5. Push to the branch (`git push origin my-new-feature`)
  6. Create new Pull Request
