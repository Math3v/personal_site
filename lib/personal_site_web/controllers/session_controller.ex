defmodule PersonalSiteWeb.SessionController do
  use PersonalSiteWeb, :controller

  alias PersonalSiteWeb.Router.Helpers
  alias PersonalSite.{Accounts, Accounts.Admin, Accounts.Guardian}

  def new(conn, _) do
    changeset = Accounts.change_admin(%Admin{})
    maybe_admin = Guardian.Plug.current_resource(conn)

    if maybe_admin do
      redirect(conn, to: "/posts")
    else
      render(conn, "new.html", changeset: changeset, action: Helpers.session_path(conn, :login))
    end
  end

  def login(conn, %{"admin" => %{"username" => username, "password" => password}}) do
    Accounts.authenticate_admin(username, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end

  defp login_reply({:ok, admin}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(admin)
    |> redirect(to: "/posts")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, "Invalid Credentials")
    |> new(%{})
  end
end
