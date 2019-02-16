defmodule PersonalSite.Pages.IndexTest do
  use PersonalSite.IntegrationCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "loads index page", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css(".title", text: "Welcome to Matej's Site!"))
  end

  test "has default seo tags", %{session: session} do
    title =
      session
      |> visit("/")
      |> page_title()

    source =
      session
      |> visit("/")
      |> page_source()

    assert title == "Matej Minarik Personal Site & Blog"
    assert source =~ "I write articles about Ruby on Rails, Elixir, Phoenix and Javascript."
  end
end
