Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { sessions: "users/sessions", confirmations: "devise/confirmations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    require "sidekiq/web"
    authenticate :admin_user do
      mount Sidekiq::Web => "/sidekiq"
    end
  end
end
