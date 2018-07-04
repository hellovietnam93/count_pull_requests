Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "users/sessions"}

  root "pages#show", page: "home"
  get "/pages/*page" => "pages#show", as: :page
  resources :repositories do
    resources :query_conditions, only: %i(new create)
  end
  namespace :count_pull_requests do
    resources :query_conditions, only: :update
  end
  resources :query_conditions, only: %i(show edit update destroy) do
    member do
      get :export
    end
  end
end
