defmodule PersonalSite.Pages.AboutTest do
  use PersonalSite.IntegrationCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "loads about page", %{session: session} do
    session
    |> visit("/about")
    |> assert_has(css(".phx-hero", text: "About Me"))
  end
end
