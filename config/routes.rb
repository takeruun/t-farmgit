Rails.application.routes.draw do

    devise_for :users, :controllers => {
    	:sessions => "users/sessions",
    	:registrations => "users/registrations",
    	:passwords => "users/passwords"
    }

	get 'posts/index' => 'posts#index'
	get 'posts/new' => 'posts#new'
	post 'posts/create' => 'posts#create'
	get 'posts/:id' => 'posts#show'

	post 'favorite/:post_id' => 'favorites#create', as: 'fav'
	delete 'favorite/:post_id' => 'favorites#destroy', as: 'unfav'


 	get '/' => 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
