Rails.application.routes.draw do
  resources :instructors, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :meetings, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :sections, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :courses, only: [:show, :update, :destroy, :new, :create, :edit]  
  devise_for :users
  get 'home/index'
  get 'home/scrapeoptions'
  post 'home/rescrape'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
