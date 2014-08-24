# omniauth-stateless

Helps [OmniAuth](https://github.com/intridea/omniauth)
to be used in a stateless manner (e.g. with REST APIs)
by authenticating during each request.

## Use case

A REST API contains resources that require authentication through
Facebook Single Sign-On on Android or iOS.

Normally OmniAuth works by intercepting requests for certain paths
(/auth/:provider/...) that are used for logging in and out. For stateless
applications we essentially wish to log in during each request.
This gem provides Rack middleware for
authenticating on every request where credentials are provided.

## Confirmed to work with these OmniAuth strategies

* [omniauth-facebook-access-token](http://github.com/kenfehling/omniauth-facebook-access-token)
* [omniauth-identity](https://github.com/intridea/omniauth-identity)

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-stateless'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-stateless

## Usage

Set up omniauth as normal.

Add this to config/application.rb

	Rails.application.config.middleware.use OmniAuth::Stateless::Builder

Add this to config/routes.rb

	mount OmniAuth::Stateless::Engine => '/'
	
Create your controller like this
	
	class Api::ItemsController < OmniAuth::Stateless::BaseController
		before_action :require_auth, only: [:create]
		respond_to :json

		def create
			...
		end
    end

Connect from your client like this
> http://example.t.proxylocal.com/api/items?provider=facebook_access_token&access_token=&lt;access token&gt;

> http://example.t.proxylocal.com/api/items?provider=identity&auth_key=&lt;email&gt;&password=&lt;password&gt;

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new pull request
