Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "users/sessions"}

  root "pages#show", page: "home"
  get "/pages/*page" => "pages#show", as: :page
end
