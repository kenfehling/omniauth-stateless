Rails.application.routes.draw do

  mount OmniAuth::Stateless::Engine => '/'
end
