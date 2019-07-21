# Load Resque Server
require 'resque/scheduler'
require 'resque/scheduler/server'
require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # namespace :api do
  #   namespace :v1 do
  #     resources :urls do
  #       collection do
  #         get 'top_100'
  #         get 'decode_url'
  #       end
  #     end
  #   end
  # end
  #Define Url Routes using api/v1 namespace

  mount Sidekiq::Web => 'api/sidekiq'
  get 'api/v1/top' , to: "api/v1/urls#top_100"
  get 'api/v1/urls' , to: "api/v1/urls#index"
  post '/url' , to: "api/v1/urls#create"
  get '/:word', to: "api/v1/urls#decode_url"

  # mount Resque::Server.new, at: "/resque"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
