Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/home",    to: "static_pages#home",    as: :home
    get "/help",    to: "static_pages#help",    as: :help
    get "/contact", to: "static_pages#contact", as: :contact

    get "demo_partials/new"
    get "demo_partials/edit"

    get "signup",   to: "users#new",            as: :signup
    post "signup",  to: "users#create"        

    resources :products
    resources :users, only: %i[show]
  end
end
