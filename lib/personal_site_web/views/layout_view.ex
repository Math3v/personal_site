defmodule PersonalSiteWeb.LayoutView do
  use PersonalSiteWeb, :view

  def signed_in?(conn), do: is_signed_in?(Guardian.Plug.current_resource(conn))

  def has_flash?(conn, key) do
    conn
    |> get_flash(key)
    |> is_binary()
  end

  def get_title(%{title: title}), do: title
  def get_title(_), do: "Matej Minarik Personal Site & Blog"

  def get_description(%{description: desc}), do: desc

  def get_description(_),
    do:
      "I'm a fullstack developer, working for PrimeHammer, Brno. I write articles about Ruby on Rails, Elixir, Phoenix and Javascript."

  defp is_signed_in?(nil), do: false
  defp is_signed_in?(_), do: true
end
