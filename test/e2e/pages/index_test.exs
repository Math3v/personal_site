defmodule PersonalSite.Pages.IndexTest do
  use PersonalSite.IntegrationCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "loads index page", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css(".title", text: "Welcome to Matej's Site!"))
  end
end
