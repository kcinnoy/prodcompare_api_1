Rails.application.routes.draw do
  devise_for :users,
             path: 'api/v1/users',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
             },
             controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
             },
             defaults: { format: :json }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  namespace :api do
    namespace :v1 do
      resources :users, except: [:index] do
        collection do
          post 'login'
        end
      end

      get '/products/', to: 'products#all'

      get '/favorites/', to: 'favorites#index'
      post 'favorites/', to: 'favorites#create'
      delete '/favorites/:id', to: 'favorites#destroy'
      # get '/favorites/:id', to: 'favorites#show'
    end
  end
end