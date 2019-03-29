# jsonapi-home

  - [![Build](http://img.shields.io/travis-ci/krainboltgreene/jsonapi-home.rb.svg?style=flat-square)](https://travis-ci.org/krainboltgreene/jsonapi-home.rb)
  - [![Downloads](http://img.shields.io/gem/dtv/jsonapi-home.svg?style=flat-square)](https://rubygems.org/gems/jsonapi-home)
  - [![Version](http://img.shields.io/gem/v/jsonapi-home.svg?style=flat-square)](https://rubygems.org/gems/jsonapi-home)

An implementation of an experimental JSON:API:Home specification, which is a combination of the [JSONHome](https://tools.ietf.org/html/draft-nottingham-json-home-06) and [json:api](https://www.jsonapi.org).


## Using

TBW

### JSON:API:Home

```
{
  data: {
    id: string,
    type: string,
    attributes: {
      tags: string | Array<string>,
      resource: string,
      intent: string,
      verb: string,
      details: null | string,
      uri-template: string,
      availability: null | "healthy" | "unhealthy" | "down" | "unknown",
      status: "usable" | "deprecated" | "gone",
      supported: boolean,
      allowed-headers: Array<{
        pointer: string,
        required: boolean,
        href: null | string | Array<string>
      }>,
      returnable-headers: Array<{
        pointer: string,
        href: null | string | Array<string>
      }>,
      allowed-path-parameters: Array<{
        pointer: string,
        required: boolean,
        href: null | string | Array<string>
      }>,
      allowed-query-parameters: Array<{
        pointer: string,
        required: boolean,
        href: null | string | Array<string>
      }>,
      allowed-body-parameters: Array<{
        pointer: string,
        required: boolean,
        href: null | string | Array<string>
      }>,
      returnable-body-parameters: Array<{
        pointer: string,
        href: null | string | Array<string>
      }>,
    }
  }
}
```

``` javascript
https://discovery.poutineer.com/v1/jsonapi-home-resources/v1-accounts-show?include=allowed-headers,return-headers,allowed-parameters,return-parameters
{
  "data": {
    "id": "v1-accounts-show",
    "type": "jsonapi-home-resources",
    "attributes": {
      "tags": ["v1"],
      "resource": "accounts",
      "intent": "show",
      "verb": "GET",
      "details": "Returns an account's data",
      "uri-template": "https://origin.poutineer.com/v1/accounts/{id}",
      "availability": "healthy",
      "status": "usable",
      "supported": true,
      "allowed-headers": [
        {
          "name": "Content-Type",
          "required": true,
          "href": "https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type"
        },
        {
          "name": "Authorization",
          "required": true,
          "href": [
            "https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization",
            "https://tools.ietf.org/html/rfc6750",
            "https://mnot.github.io/I-D/how-did-that-get-into-the-repo/"
          ]
        },
        {
          "name": "If-Modified-Since",
          "required": false,
          "href": "https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/If-Modified-Since"
        },
        {
          "name": "If-Match",
          "required": false,
          "href": [
            "https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/If-Match"
          ]
        }
      ],
      "returnable-headers": [
        {
          "name": "Date",
          "href": "https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Date"
        },
        {
          "name": "Set-Cookie",
          "href": "https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie"
        },
        {
          "name": "If-Modified-Since",
          "href": "https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/If-Modified-Since"
        },
        {
          "name": "Etag",
          "href": "https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Etag"
        }
      ],
      "allowed-parameters": [
        {
          "pointer": "/data"
        }
      ],
      "created-at": "2018-08-14T20:25:00-07:00Z",
      "updated-at": "2018-08-15T10:23:30-07:00Z"
    }
  }
}
```
Server: Cowboy
Date: Mon, 13 Aug 2018 23:47:20 GMT
Connection: keep-alive
Content-Type: application/vnd.api+json; charset=utf-8
Vary: Accept-Encoding, Origin
Etag: W/"c6e76bb30f5bb2319a7ece4133371045"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: 9eee93cb-ffe1-451d-aec2-3527656281f7
X-Runtime: 0.067881
Transfer-Encoding: chunked
Via: 1.1 vegur

### Rails

TBW

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

## Configuration

plugin -> configuration -> global defaults -> resource defaults -> defaults

``` ruby
JSONAPI::Home.configuration do |home|
  # header: X-Real-IP

  home.plugin :rails, automatic_routes: true, cookies: true, compression: true
  # header: X-Request-Id: <uuid>
  # header: Host
  # header: Accept
  # header: Via
  # header: Content-Type
  # header: X-Forwarded-For
  # header: Content-Length: <integer>
  # header: X-Runtime: <integer>

  # cookies
  # header: Cookie: <cookie-list> Max-Age=<non-zero-digit>; SameSite=Strict
  # header: Set-Cookie: <cookie-name>=<cookie-value>; Domain=<domain-value>; Path=<path-value>; Secure; HttpOnly; Expires=<date>;

  # compression
  # header: Transfer-Encoding: chunked
  # header: Transfer-Encoding: compress
  # header: Transfer-Encoding: deflate
  # header: Transfer-Encoding: gzip
  # header: Transfer-Encoding: identit

  home.plugin :rack_cors
  # verb: OPTIONS if match

  home.plugin :rack_sendfile
  # header: X-Sendfile-Type
  # header: X-Sendfile
  # header: X-Lighttpd-Send-File
  # header: X-Accel-Redirect
  # header: X-Accel-Mapping

  home.plugin :rack_csrf
  # header: X-CSRF-Token

  home.plugin :secure_headers
  # header: Strict-Transport-Security
  # header: X-Frame-Options
  # header: X-Content-Type-Options
  # header: X-Xss-Protection
  # header: X-Download-Options
  # header: X-Permitted-Cross-Domain-Policies
  # header: Content-Security-Policy

  home.plugin :rack_cache
  # header: Cache-Control: public, private, max-age, s-maxage, must-revalidate, and proxy-revalidate
  # header: If-Modified-Since
  # header: If-Unmodified-Since
  # header: If-Match
  # header: If-None-Match
  # header: Etag
  # header: Last-Modified
  # header: Expires
  # header: X-Rack-Cache

  home.plugin :rack_attack
  # header: Retry-After

  home.plugin :authentication, type: :bearer
  # header: Authorization

  home.defaults(
    allows_headers: {
      "Accept" => {
        "Content-Type": {"application/vnd.api+json": {"charset": "utf-8"}},
      }
    }
  )
  home.resource :accounts, inherit: false, defaults: {
    allows_headers: {
      "Accept" => {
        "Content-Type": {"application/vnd.api+json": {"charset": "utf-8"}},
      }
    }
  }
  home.action :accounts, :index, inherit: false, options: {
    allows_headers: {
      "Accept" => {
        "Content-Type": {"application/vnd.api+json": {"charset": "utf-8"}},
      }
    }
  }
end
```

## Todo

  - [ ] New fields
    - [x] status (optional)
    - [x] precondition (optional)
    - [x] allows-headers
      - [ ] if the header is in a special list, link to that header's documentation
    - [ ] returns-headers
    - [ ] allows-payload
    - [ ] returns-payload
  - [ ] remove description default
  - [ ] Handle OPTIONS + HEAD
  - [ ] schemas???
    - [ ] jsonapi created at = boot
  - [ ] smart_params for self
  - [ ] rename location to origin
  - [ ] Configuration
    - [ ] per project
    - [ ] per resource
    - [ ] per endpoint
  - [ ] Plugin for rack-cors
  - [ ] Plugin for rack-cache
  - [ ] Plugin for jsonapi endpoint
  - [ ] Plugin for rack-protection
  - [ ] Plugin for

## Installing

Add this line to your application's Gemfile:

    gem "jsonapi-home", "2.0.0"

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
