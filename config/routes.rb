Rails.application.routes.draw do

  namespace :user do
    resources :posts, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  end
  scope module: :user do
    root to: 'homes#top'
    get "about" => "homes#about", as:"about"
    
    
  end
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end