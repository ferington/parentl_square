Rails.application.routes.draw do

  resources :tasks
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

   devise_for :customers, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  namespace :admin do


  end
  scope module: :user do
    root to: 'homes#top'
    get "about" => "homes#about", as:"about"
    get "search_tag" => "post#search_tag"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :posts

  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end