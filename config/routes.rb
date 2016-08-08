Rails.application.routes.draw do
  use_doorkeeper
  root "landings#index"
  scope "/user", controller: "users" do
    get "/new", action: :new
    post "/create", action: :create
    scope "session", controller: "sessions" do
      get "/new", action: :new, as: :new_session
      post "/create", action: :create, as: :create_session
      post "/logout", action: :logout
    end
  end

  namespace :api do
    namespace :v1 do
      # post "/bucketlists", to: "bucketlists#create"
      # get "/bucketlists", to: "bucketlists#all"
      # get "/bucketlists/:id", to: "bucketlists#show"
      # put "/bucketlists/:id", to: "bucketlists#update"
      # delete "/bucketlists/:id", to: "bucketlists#destroy"
      # post "/bucketlists/:id/items", to: "items#create"
      # get "/bucketlists/:id/items", to: "items#all"
      # get "/bucketlists/:id/items/:item_id", to: "items#show"
      # put "/bucketlists/:id/items/:item_id", to: "items#update"
      # delete "/bucketlists/:id/items/:item_id", to: "items#destroy"
    end
  end
end
