defmodule PersonalSiteWeb.LayoutView do
  use PersonalSiteWeb, :view

  def signed_in?(conn), do: is_signed_in?(Guardian.Plug.current_resource(conn))

  def has_flash?(conn, key) do
    conn
    |> get_flash(key)
    |> is_binary()
  end

  defp is_signed_in?(nil), do: false
  defp is_signed_in?(_), do: true
end
