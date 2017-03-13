Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show,:edit,:update]
  root 'friends#index'
  resources :timelines,only: [:index,:new,:create,:edit,:update,:destroy]
  resources :talks,only: [:index,:show,:create,:destroy]
  resources :comments,only: [:new,:create]
  resources :friends do
  	collection do
  		post 'result'
  	end
  end
end
