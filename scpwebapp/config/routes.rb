Scpwebapp::Application.routes.draw do
  resources :visitors

  get "language/english"
  get "language/spanish"
  get 'api/authorize_plate', defaults: {format: :json}
  get 'api/latest_logs', defaults: {format: :json}
  
  
  resources :logs

  resources :cam_locations

  resources :vehicles

  resources :clients

  resources :models

  resources :brands

  resources :roles
  
  resources :identities
  
  resources :people

  root "pages#home"
  get 'contact' => 'pages#contact', as: :contact
  get 'about' => 'pages#about', as: :about
  get '/livelog' => 'pages#livelog', as: :livelog
  
  post '/auth/:provider/callback' => 'sessions#create' #omniauth route
  get '/signup' => 'identities#new', as: :signup
  get "/auth/failure", to: "sessions#failure"
  get '/login' => 'sessions#new', as: :login
  get '/logout' => 'sessions#destroy', as: :logout
  
  
  get '/account' => 'people#account', as: :account
  get '/client/person/new' => 'clients#newpersonclient', as: :newclientperson
  get 'client/new_vehicle/:id' => 'clients#new_vehicle', as: :new_client_vehicle
  
end
