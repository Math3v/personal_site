defmodule PersonalSiteWeb.PageController do
  use PersonalSiteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
