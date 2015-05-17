Rails.application.routes.draw do
  namespace :admin do
    root 'books#index'
    get 'books/reserve_list' => 'books#reserve_list'
    get 'books/outtime_list' => 'books#outtime_list'
    get 'books/restitution_list' => 'books#restitution_list'
    get 'books/honor_list' => 'books#honor_list'
    patch 'books/reserve/:id' => 'books#reserve'
    patch 'books/restitution/:id' => 'books#restitution'

    resources :activities
    resources :tags
    resources :evaluations
    resources :donors
    resources :books
    resources :users
  end

  root 'books#index'
  resources :books
  resources :users
  resources :activities
  resources :donors
end
