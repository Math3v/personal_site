defmodule PersonalSiteWeb.PostView do
  use PersonalSiteWeb, :view

  def post_disabled?(post), do: is_post_disabled?(post.published_at)

  def format_datetime(%DateTime{day: day, month: month, year: year}) do
    "#{make_two_digit(day)}. #{make_two_digit(month)}. #{year}"
  end

  defp make_two_digit(number) when number < 10, do: "0#{number}"
  defp make_two_digit(number), do: "#{number}"

  defp is_post_disabled?(published_at) when is_nil(published_at), do: true
  defp is_post_disabled?(_), do: false
end
