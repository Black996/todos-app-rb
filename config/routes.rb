Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :todos do
    resources :items
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
