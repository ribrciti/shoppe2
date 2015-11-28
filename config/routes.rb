Rails.application.routes.draw do
	
  resources :orders
  resources :ordered_items
  resources :carts
	resources :products
	
	 root 'store#index', as: 'store'
  
end