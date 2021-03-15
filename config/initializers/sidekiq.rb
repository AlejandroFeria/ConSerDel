if Rails.env.development?
  require 'sidekiq'
  require 'sidekiq/web'
  Sidekiq.default_worker_options = { retry: 0 }
end
