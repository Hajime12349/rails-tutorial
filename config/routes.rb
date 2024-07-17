Rails.application.routes.draw do
  root "static_pages#home"
  get 'foo/bar'
  get 'foo/baz'
  get "/home", to: "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/help", to: "static_pages#help"
  get '/contact', to: "static_pages#contact"
  get '/signup', to: "users#new"
end
