Rails.application.routes.draw do
  root 'static_pages#home'
  post '/cases' => 'cases#create'
end
