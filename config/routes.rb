Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }
  devise_for :end_users, controllers: {
    sessions: 'end_users/sessions',
    passwords: 'end_users/passwords',
    registrations: 'end_users/registrations'
  }

	root 'home#top'
	get '/about', to: 'home#about'
	get '/admin', to: 'admin#top'
	patch '/end_users/withdraw', to: 'public/end_users#withdraw', as: 'withdraw'
	get '/orders/thanks', to: 'public/orders#thanks'
	get '/end_users/confirm', to: 'public/end_users#confirm'
	post '/orders/confirm', to: 'public/orders#confirm'
  delete '/cart_items/destroy_all', to: 'public/cart_items#destroy_all'
  get '/admin/searches', to: 'admin/searches#search'
  
  scope module: 'public' do
    resource :end_user, only: [:show, :edit, :update]
    resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:index, :show, :create, :edit, :new]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :items, only: [:index, :show]
  end

  namespace :admin do
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
