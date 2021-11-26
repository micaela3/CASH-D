Rails.application.routes.draw do
  resources :graders, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :instructors, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :meetings, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :sections, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :courses, only: [:show, :update, :destroy, :new, :create, :edit]  
  devise_for :users
  get 'home/index'
  get 'home/scrapeoptions'
  post 'home/rescrape'
  root 'home#index'
  get 'grader/application', to:'grader_application#get'
  post 'grader/application', to:'grader_application#post'
  get 'recommendations', to:'recommendations#get'
  post 'recommendations', to: 'recommendations#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
