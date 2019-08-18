Rails.application.routes.draw do
  get 'main/index'
  root 'main#index'

  get '/phone_number', to: 'main#phone_number'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
