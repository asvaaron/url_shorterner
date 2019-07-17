Rails.application.routes.draw do
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
  # Define Url Routes using api/v1 namespace
  get '/top' , to: "api/v1/urls#top_100"
  post '/url' , to: "api/v1/urls#create"
  get '/:word', to: "api/v1/urls#decode_url"

  # mount Resque::Server.new, at: "/resque"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
