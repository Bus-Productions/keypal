Keypal::Application.routes.draw do

  
  match "requests/incoming" => "requests#incoming"

  match 'users/verify' => 'users#verify', :as => "verify"

  match 'users/login' => 'users#login'

  match 'users/list_all' => 'users#list_all'

  root :to => "users#index"


  resources :outbounds


  resources :keys


  resources :users


  resources :requests


  resources :charges

end
