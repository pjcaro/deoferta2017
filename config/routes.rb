Rails.application.routes.draw do
  resources :people
  resources :productos
  root 'productos#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
