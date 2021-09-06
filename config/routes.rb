Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/test', to: 'tester#index'
  resources :articles, only: [:show, :index]
end
