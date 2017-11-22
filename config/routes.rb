Rails.application.routes.draw do
  devise_for :users
  resources :productos
  resources :favoritos, only: [:create, :destroy, :index]
  root 'productos#search'

  get 'productos/:id/historial', to: 'productos#historial', as: 'historial_producto'
  get 'filter', to: 'productos#filter', as: 'filter_productos'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
