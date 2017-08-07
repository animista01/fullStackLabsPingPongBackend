Rails.application.routes.draw do

  devise_for :users

  #API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :sessions, only: [:create]

      resources :users, only: [:create]
      scope 'users' do
        get '/opponents', to: 'users#opponents'
      end

      resources :games, only: [:create, :index, :show]
      resources :leaderboard, only: [:index]
    end
  end

  # Options Req
  match '/api/v1/*path', via: [:options], to:  lambda { |_| [204, { 'Content-Type' => 'text/plain' }, []] }
end
