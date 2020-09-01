Rails.application.routes.draw do
	root 'home#top'
	get '/about', to: 'home#about'
	get '/admin', to: 'admin#top'
	patch '/end_users/withdraw'
	get '/orders/thanks'
	get '/end_users/confirm'
	post '/orders/confirm'
  delete '/cart_items/destroy_all'
  resource :end_users, only: [:show, :edit, :update]
  resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]
  resources :orders, only: [:index, :create, :edit, :new]
  resources :cart_items, only: [:index, :create, :update, :destroy]
  resources :items, only: [:index, :show]


  namespace :admin do
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :genre, only: [:index, :create, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
