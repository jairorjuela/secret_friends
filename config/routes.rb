Rails.application.routes.draw do
  root to: 'games#index', via: :all

  resources :workers, only: %i[create index]
  resources :locations, only: %i[create index]
  resources :games, only: %i[create index show]
end
