Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'profile', to: 'users#show'
  # get 'admin', to: 'users#admin_index'

  get 'adverts', to: 'home#index'

  resources :users do
    resources :adverts
  end


  namespace :admin do
    resources :users, only: [:show]
    resources :adverts
    resources :categories, only: [:create, :destroy, :update]
    get '', to: 'adverts#index'
  end



  
  root 'home#index'
end
