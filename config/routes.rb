Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/home",    to: "static_pages#home",    as: :home
    get "/help",    to: "static_pages#help",    as: :help
    get "/contact", to: "static_pages#contact", as: :contact

    get "demo_partials/new"
    get "demo_partials/edit"

    get "signup",   to: "users#new",            as: :signup
    post "signup",  to: "users#create"        

    get "login",    to: "sessions#new",         as: :login
    post "login",   to: "sessions#create"
    delete "logout",to: "sessions#destroy",     as: :logout

    resources :products
    resources :users
  end
end
