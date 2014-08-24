require 'addressable/uri'
require 'oauth2'

module OmniAuth
    module Stateless
        class Builder < ::Rack::Builder

            def initialize(app)
                @app = app
            end

            def call(env)
                uri = Addressable::URI.parse env['REQUEST_URI']
                if uri.path.start_with? '/auth/'
                    auth env
                else
                    params = uri.query_values || {}
                    if params.has_key? 'provider'
                        auth_env = env.clone
                        auth_env['REQUEST_METHOD'] = 'GET'
                        auth_path = "/auth/#{params['provider']}/callback"
                        auth_uri = "#{auth_path}?#{uri.query}"
                        auth_env['REQUEST_PATH'] = auth_path
                        auth_env['PATH_INFO'] = auth_path
                        auth_env['QUERY_STRING'] = uri.query
                        auth_env['REQUEST_URI'] = auth_uri
                        auth_env['ORIGINAL_FULLPATH'] = auth_uri

                        status, headers, response = auth auth_env
                        if status == 200
                            #params.delete('access_token')
                            #params.delete('provider')
                            uri.query_values = params
                            env['omniauth.auth'] = auth_env['omniauth.auth']
                            env['omniauth.strategy'] = auth_env['omniauth.strategy']
                            env['omniauth.params'] = auth_env['omniauth.params']
                            env['omniauth.origin'] = auth_env['omniauth.origin']
                            env['REQUEST_URI'] = uri.to_s
                            env['QUERY_STRING'] = uri.query
                            @app.call env
                        else
                            [status, headers, response]
                        end
                    else
                        @app.call env
                    end
                end
            end

            private

            def auth(env)
                begin
                    @app.call env
                rescue OAuth2::Error => e
                    [401, { 'Content-Type' => 'application/json' }, [{
                         :error => e.response.parsed['error']['message']
                    }.to_json]]
                end
            end

        end
    end
end