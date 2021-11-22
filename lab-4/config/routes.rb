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
  get 'grader/application/new', to:'grader_application#getNew'
  get 'grader/application/edit', to:'grader_application#edit'
  post 'grader/application/new', to:'grader_application#postNew'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
