Keypal::Application.routes.draw do

  
  match "requests/incoming" => "requests#incoming"

  match 'users/verify' => 'users#verify', :as => "verify"

  match 'users/login' => 'users#login'

  match 'users/list_all' => 'users#list_all'

  match 'info' => 'requests#info', :as => "info"

  match 'charges/cancel' => 'charges#cancel', :as => "cancel"

  match 'charges/upgrade' => 'charges#upgrade', :as => "upgrade"

  root :to => "users#index", :as => "home"


  resources :outbounds


  resources :keys


  resources :users


  resources :requests


  resources :charges

end
