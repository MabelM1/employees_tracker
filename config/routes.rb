Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/auth/facebook/callback' => 'sessions#fb_login'

  get "/" , to: 'users#home'
  patch "user/:id/update_password" => "users#update_password"
  
  resources :users do
    resources :employees do
      resources :pay_roles
    end
    resources :buildings
    resources :work_orders  
    get "work_orders/:id/close" => "work_orders#close"
  end

  resources :sessions
  delete '/signout', to: 'sessions#destroy'
  get '/comments' => 'comments#new'
  post 'comments' => 'comments#create'

  resources :comments do
    resources :replies
  end
end
