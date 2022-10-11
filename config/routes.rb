Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'

  namespace :users do
    resources :users, path: '/'
  end


  namespace :slots do
    resources :slots, path: '/'
  end

  namespace :floors do
    resources :floors, path: '/' do
      get '/floors/:id', to: 'floors#show'
    end
  end

  resources :floors do
    resources :slots do
    end

    # namespace :floors do
    #   resources :slots do
    #   end
end

end