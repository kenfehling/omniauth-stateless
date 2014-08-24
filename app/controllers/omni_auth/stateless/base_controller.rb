module OmniAuth
    module Stateless
        class BaseController < ActionController::Base
            protect_from_forgery with: :null_session
            respond_to :json

            private

            def fail_auth
                render json: { error: 'Not logged in' }, status: 401
            end

            protected

            def require_auth
                auth_hash = request.env['omniauth.auth']
                if auth_hash.nil?
                    fail_auth
                else
                    provider = auth_hash['provider']
                    uid = auth_hash['uid']
                    @auth = Authorization.find_by_provider_and_uid(provider, uid)
                    unless @auth
                        fail_auth
                    end
                end
            end
        end
    end
end