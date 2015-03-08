Rails.application.routes.draw do
  get 'protected_pages/download_csv'

  # devise_for :users #before rails generate devise:controllers users
  devise_for :users, controllers: { sessions: "users/sessions" } #after rails generate devise:controllers users
  root 'static_pages#home'
  post '/cases' => 'cases#create'
end
