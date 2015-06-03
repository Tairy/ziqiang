Rails.application.routes.draw do
  namespace :admin do
    root 'books#index'
    # get 'books/reserve_list' => 'books#reserve_list'
    get 'books/outtime_list' => 'books#outtime_list'
    # get 'books/restitution_list' => 'books#restitution_list'
    get 'books/honor_list' => 'books#honor_list'
    # patch 'books/reserve/:id' => 'books#reserve', as: :book_reserve
    # patch 'books/restitution/:id' => 'books#restitution', as: :book_rest
    match 'books/restitution_list', to: 'books#restitution_list', via: 'get', as: :book_restitutionlist
    match 'books/reserve_list', to: 'books#reserve_list', via: 'get', as: :book_reservelist
    match 'books/reserve/:id', to: 'books#reserve', via: 'post', as: :book_reserve
    match 'books/restitution/:id', to: 'books#restitution', via: 'post', as: :book_rest

    resources :activities
    resources :tags
    resources :evaluations
    resources :donors
    resources :books
    resources :users
  end

  match '/donors/search', to: 'donors#search', via: 'post'
  match '/donors/donor/:book_id', to: 'donors#donor', via: 'get'
  match '/books/reserve/:id', to: 'books#reserve', via: 'get', as: :book_reserve
  match '/books/restitution/:id', to: 'books#restitution', via: 'get', as: :book_rest
  match '/users/borrow/:id', to: 'users#borrow', via: 'get', as: :borrow
  
  root 'books#index'
  resources :books
  resources :users
  resources :activities
  resources :donors
end
