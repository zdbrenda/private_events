Rails.application.routes.draw do
  root to: "events#index"
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/users/:id', to:"users#show", as: "user"
  resources :events
  get '/users/:user_id/events/:id', to:"attending_events#new", as: "new_attending_event"
  post '/users/:user_id/events/:id', to:"attending_events#create", as: "create_attending_event"
  get '/users/:id/attended_events', to:"users#show_attended_events", as: "show_attended_events"
  delete '/users/:user_id/events/:id', to: "attending_events#destroy", as: "destroy_attending_event"
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :events, only: [:index, :create, :show, :update, :destroy]
      resources :users, only: [:show, :update]
    end
  end

  get '/api/v1/events/:id/attendees', to: "api/v1/events#show_attendees", format: :json
  post '/api/v1/events/:id/register', to: "api/v1/events#register", format: :json
  get '/api/v1/users/:id/events', to: "api/v1/users#show_registered_events", format: :json
  post '/api/v1/events/:id/deregister', to: "api/v1/events#deregister", format: :json

  namespace :user do
    resource :private_api_keys, only: :update
  end
end
