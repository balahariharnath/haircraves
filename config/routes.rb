Rails.application.routes.draw do
  # resources :rating_appointments
  # resources :services
  get 'device_infos/create'
  # resources :orders
  # resources :appointments
  # resources :banks
  # resources :cards
  # resources :addresses
  # resources :comments
  # resources :items
  # resources :categories
  # resources :availabilities
  devise_for :users
  # resources :users

  namespace :api do
    get 'get_roles', to: 'general_infos#get_roles'
    post 'create_user', to: 'users#create_user'
    patch 'update_profile', to: 'users#update_profile'
    get 'forgot_password', to: 'users#forgot_password'

    post 'create_service', to: 'services#create_service'
    get 'service_list', to: 'services#service_list'
    patch 'edit_service', to: 'services#edit_service'
    get 'destroy_service', to: 'services#destroy_service'
    get 'service_category', to: 'services#service_categories'
    get 'profile', to: 'services#profile'
    get 'service_providers', to: 'services#service_providers'

    get 'availability_list', to: 'availabilities#availability_list'
    patch 'update_availability', to: 'availabilities#update_availability'

    post 'create_product_category', to: 'categories#create'
    get 'category_list', to: 'categories#category_list'

    post 'create_item', to: 'items#create'
    patch 'update_item', to: 'items#update'
    get 'destroy_item', to: 'items#destroy'
    get 'items_list', to: 'items#items_list'
    get 'item_details', to: 'items#details'

    post 'create_post', to: 'posts#create'
    get 'post_details', to: 'posts#post_details'
    get 'post_list', to: 'posts#post_list'
    post 'like_post', to: 'posts#like_post'

    post 'create_comment', to: 'comments#create'

    post 'create_booking', to: 'appointments#create_booking'
    patch 'update_appointment', to: 'appointments#update'
    get 'my_bookings', to: 'appointments#my_bookings'
    get 'appointment_details', to: 'appointments#details'


    post 'create_address', to: 'addresses#create'
    patch 'update_address', to: 'addresses#update'
    get 'destroy_address', to: 'addresses#destroy'
    get 'address_list', to: 'addresses#address_list'

    post 'create_card', to: 'cards#create'
    get 'destroy_card', to: 'cards#destroy'

    post 'add_cart', to: 'carts#create'
    get 'cart', to: 'carts#cart_list'
    get 'remove_item', to: 'carts#remove_item'
    # patch 'update_qty', to: 'carts#update_qty'

    post 'add_item_favourites', to: 'item_favorites#add_item_favourites'
    get 'item_favourites', to: 'item_favorites#item_favourites'
    post 'add_service_favourites', to: 'item_favorites#add_service_favourites'
    get 'favourite_service_providers', to: 'item_favorites#favourite_service_providers'

    post 'create_portfolio', to: 'portfolios#create'
    patch 'update_portfolio', to: 'portfolios#update'
    get 'destroy_portfolio', to: 'portfolios#destroy'
    get 'portfolio', to: 'portfolios#index'


    get 'check_api', to: 'users#check_api'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "users#index"
end
