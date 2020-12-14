Rails.application.routes.draw do
  devise_for :users, only: [:sessions]

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        scope module: :auth do
          resource :sessions, only: [:create, :destroy]
        end
      end

      resources :users, only: [:index]
    end
  end

  # get '*path', to: "application#fallback_index_html", constraints: ->(request) do
  #   !request.xhr? && request.format.html?
  # end
end
