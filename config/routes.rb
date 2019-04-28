Rails.application.routes.draw do

  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  post 'posts/create' => 'posts#create'

  
  get  'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'

  get '/' => 'home#top'
  get '/change' => 'home#change'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
