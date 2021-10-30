Rails.application.routes.draw do
  resources :instructors
  resources :meetings
  resources :sections
  resources :courses
  devise_for :users
  get 'home/index'
  post 'home/rescrape'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
