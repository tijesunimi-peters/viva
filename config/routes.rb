Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: "oauth/applications"
  end
  root "landings#index"

  get "/docs", to: redirect("/docs/index.html")

  scope "/user", controller: "users" do
    get "/new", action: :new
    post "/create", action: :create
    scope "session", controller: "sessions" do
      get "/new", action: :new, as: :new_session
      post "/create", action: :create, as: :create_session
      get "/logout", action: :logout
    end
  end

  namespace :api do
    namespace :v1 do
      get "/user", to: "users#show"
      post "/bucketlists", to: "bucketlists#create"
      get "/bucketlists", to: "bucketlists#index"
      get "/bucketlists/:id", to: "bucketlists#show"
      put "/bucketlists/:id", to: "bucketlists#update"
      delete "/bucketlists/:id", to: "bucketlists#destroy"
      post "/bucketlists/:id/items", to: "items#create"
      get "/bucketlists/:id/items", to: "items#index"
      get "/bucketlists/:id/items/:item_id", to: "items#show"
      put "/bucketlists/:id/items/:item_id", to: "items#update"
      delete "/bucketlists/:id/items/:item_id", to: "items#destroy"
    end
    match "*url", to: "apis#route_not_found", via: :all
  end

  match "*url", to: "application#route_not_found", via: :all
end
