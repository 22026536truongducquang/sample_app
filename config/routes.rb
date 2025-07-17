Rails.application.routes.draw do
<<<<<<< HEAD
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
  
    get "/static_pages/home",    to: "static_pages#home",    as: "home"
    get "/static_pages/help",    to: "static_pages#help",    as: "help"
    get "/static_pages/contact", to: "static_pages#contact", as: "contact"

    resources :products
=======
  resources :products
  get "demo_partials/new"
  get "demo_partials/edit"
  get "static_pages/home"
  get "static_pages/help"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/help", to: "static_pages#help"
    resources :products
    # Các route khác...
>>>>>>> 28f4749 (chapter_3_4_5)
  end
end
