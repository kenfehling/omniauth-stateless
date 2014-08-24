OmniAuth::Stateless::Engine.routes.draw do
    get '/auth/:provider/callback', :to => 'sessions#create'
    post '/auth/:provider/callback', :to => 'sessions#create'
    get '/auth/failure', :to => 'sessions#failure'
end