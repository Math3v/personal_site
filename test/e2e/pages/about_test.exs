defmodule PersonalSite.Pages.AboutTest do
  use PersonalSite.IntegrationCase, async: true

  import Wallaby.Query, only: [css: 2, link: 1]

  test "loads about page", %{session: session} do
    session
    |> visit("/about")
    |> assert_has(css(".phx-hero", text: "About Me"))
  end

  test "index page links to about page", %{session: session} do
    session
    |> visit("/")
    |> click(link("About"))
    |> assert_has(css(".phx-hero", text: "About Me"))
  end
end
