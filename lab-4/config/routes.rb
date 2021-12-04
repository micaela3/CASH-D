Rails.application.routes.draw do
  resources :graders, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :instructors, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :meetings, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :sections, only: [:show, :update, :destroy, :new, :create, :edit] do
    get 'showGraders'
    get 'showGraders/availabilities', to: 'sections#availabilities'
    get 'showGraders/recommendations', to: 'sections#recommendations'
    post 'assignGrader'
    post 'unassignGrader'
  end
  resources :courses, only: [:show, :update, :destroy, :new, :create, :edit]  
  devise_for :users
  get 'home/index'
  get 'home/scrapeoptions'
  post 'home/rescrape'
  root 'home#index'
  get 'grader/application', to:'grader_application#get'
  post 'grader/application', to:'grader_application#post'
  post 'grader/application/delete', to:'grader_application#deleteForm'
  get 'recommendations', to:'recommendations#get'
  post 'recommendations', to: 'recommendations#new'
  delete 'recommendations/delete', to: 'recommendations#delete'
  get 'recommendations/edit', to: 'recommendations#edit'
  patch 'recommendations', to: 'recommendations#update'
  get 'recommendations/display', to: 'recommendations#display'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
