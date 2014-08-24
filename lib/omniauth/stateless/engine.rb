module OmniAuth
    module Stateless
        class Engine < ::Rails::Engine
            isolate_namespace OmniAuth::Stateless
        end
    end
end