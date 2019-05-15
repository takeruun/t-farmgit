Rails.application.routes.draw do

    devise_for :users, :controllers => {
    	:sessions => "users/sessions",
    	:registrations => "users/registrations",
    	:passwords => "users/passwords"
    }
	get 'users/:id' => 'users#show'

	resources :posts do
		resources :favorites, only: [:create, :destroy]
	end


 	get '/' => 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
