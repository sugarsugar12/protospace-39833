Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #？

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "prototypes#index"
  #↑prototypes_controllerのindexアクションが稼働する
  #resources :prototypes, only: [:new, :create,:index,:show,:edit,:update,:destroy] do
  resources :prototypes do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
