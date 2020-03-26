Rails.application.routes.draw do
  get 'home/about' => 'homes#about'
  devise_for :users
  root 'books#top'
  resources :books, only: [:top, :new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
