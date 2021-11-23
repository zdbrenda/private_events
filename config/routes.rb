Rails.application.routes.draw do
  root to: "events#index"
  devise_for :users, :controllers => { registrations: 'registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/users/:id', to:"users#show", as: "user"
  resources :events
  get '/users/:user_id/events/:id', to:"attending_events#new", as: "new_attending_event"
  post '/users/:user_id/events/:id', to:"attending_events#create", as: "create_attending_event"
  get '/users/:id/attended_events', to:"users#show_attended_events", as: "show_attended_events"
  delete '/users/:user_id/events/:id', to: "attending_events#destroy", as: "destroy_attending_event"
  
  
end
