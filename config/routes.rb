Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :api do
    namespace :v1 do
      resources :books, only: %i[create index destroy]

      post 'registration', to: 'users#create'
      post 'registration/confirm', to: 'users#confirm_email'
      get 'registration/confirm', to: 'users#send_confirmation'

      post 'authenticate', to: 'authentication#create'
    end
  end
end
