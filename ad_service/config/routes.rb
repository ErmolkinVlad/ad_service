Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/index'

  # get 'admin'

  get 'adverts', to: redirect('home/index')

  resources :users do
    resources :adverts
  end
  
  root 'home#index'
end
