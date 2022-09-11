Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    root to: 'games#index', via: :all

    resources :workers, only: %i[create index]
    resources :locations, only: %i[create index]
    resources :games, only: %i[create index show]
  end
end
