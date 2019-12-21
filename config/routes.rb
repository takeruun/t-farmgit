Rails.application.routes.draw do
    root 'home#top'

    devise_for :users, :controllers => {
    	:sessions => "users/sessions",
    	:registrations => "users/registrations",
    	:passwords => "users/passwords"
    }
	
    resources :users, only: [:show]

    get 'users/:id/favorites' => 'users#favorites', as: "user_favorites"

	resources :posts do
		resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
