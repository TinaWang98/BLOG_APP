Rails.application.routes.draw do
  devise_for :users
  resources :blogs do
    resources :comments, only: [:create]
  end
  root "blogs#index"
end
