Rails.application.routes.draw do
  root 'task#input'
  post 'result', to: 'task#show'
  
  # get 'task/input', to: 'task#input'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
