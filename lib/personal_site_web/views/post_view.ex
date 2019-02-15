defmodule PersonalSiteWeb.PostView do
  use PersonalSiteWeb, :view

  def post_disabled?(post), do: is_post_disabled?(post.published_at)

  defp is_post_disabled?(published_at) when is_nil(published_at), do: true
  defp is_post_disabled?(_), do: false
end
