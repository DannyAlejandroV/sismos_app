Rails.application.routes.draw do
    namespace :api do
    resources :features, only: [:index] do
      post 'create_comment', on: :collection
      root 'welcome#index'
    end
  end
end
