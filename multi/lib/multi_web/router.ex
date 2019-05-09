defmodule MultiWeb.Router do
  use MultiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MultiWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", PageController, :login_view
    post "/login", PageController, :login
    get "/logout", PageController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", MultiWeb do
  #   pipe_through :api
  # end
end
