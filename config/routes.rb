Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [ :index, :new, :create, :edit, :update, :destroy ]
  end
  devise_for :installs

  # Other routes...
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "posts#index"
end
