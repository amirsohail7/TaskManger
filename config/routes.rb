Rails.application.routes.draw do
  resources :tasks do
    patch 'toggle_status', on: :member
  end
  root to: 'tasks#index'
end
