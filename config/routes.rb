Rails.application.routes.draw do

	
	root 'questions#index'
	get 'login', to: 'sessions#new'
  	post 'login', to: 'sessions#create'
  	delete 'logout', to: 'sessions#destroy'

	resources :users, only: [:new, :create]
	resources :questions do
		resources :answers, only: [:create]
		resource :vote, only: [:create, :destroy]
	end


	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
