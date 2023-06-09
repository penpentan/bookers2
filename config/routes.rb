Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  resources :books, only:[:new,:create,:destroy,:edit,:index,:show,:update] do
    resources :book_comments, only:[:create,:destroy]
    resource :favorites, only:[:create,:destroy]
  end
  resources :users, only:[:new,:create,:edit,:index,:show,:update]
  get "/home/about" => "homes#about" , as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
