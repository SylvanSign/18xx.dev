defmodule TrainsWeb.Router do
  use TrainsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TrainsWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/tile", TileLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrainsWeb do
  #   pipe_through :api
  # end
end
