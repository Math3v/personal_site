defmodule PersonalSiteWeb.Router do
  use PersonalSiteWeb, :router

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

  pipeline :auth do
    plug PersonalSite.Accounts.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", PersonalSiteWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    resources "/posts", PostController, except: [:index, :show]
  end

  scope "/", PersonalSiteWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout

    resources "/posts", PostController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PersonalSiteWeb do
  #   pipe_through :api
  # end
end
