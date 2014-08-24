module OmniAuth
    module Stateless
        class SessionsController < ApplicationController
            def create
                auth_hash = request.env['omniauth.auth']
                @auth = Authorization.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])
                if @auth
                    #raise auth_hash.to_yaml
                    render :json => {}, :status => 200
                else
                    user = User.new :name => auth_hash['info']['name'],
                                    :email => auth_hash['info']['email']
                    user.authorizations.build :provider => auth_hash['provider'],
                                              :uid => auth_hash['uid']
                    user.save
                    render :json => {}, :status => 200
                end
            end

            def failure
                render :json => {}, status: 401
            end
        end
    end
end