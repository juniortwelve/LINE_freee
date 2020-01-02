Rails.application.routes.draw do
  get 'relationships/index'
  get 'relationships/create'
  devise_for :users, controllers: { registrations: 'registrations'}
  resources :users, :only => [:index, :show]
  root "users#index"
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :relationships, :only => [:create, :index, :update, :destroy]
  #mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
