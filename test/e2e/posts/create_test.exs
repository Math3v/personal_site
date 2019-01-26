defmodule PersonalSite.Posts.CreateTest do
  use PersonalSite.IntegrationCase

  import Wallaby.Query, only: [css: 2, text_field: 1, button: 1, link: 1, select: 1]

  test "creates post and navigates to index", %{session: session} do
    session
    |> visit("/posts/new")
    |> fill_in(text_field("Title"), with: "New Post")
    |> fill_in(text_field("Body"), with: "New Content")
    |> set_value(select("Tags"), "option1")
    |> fill_in(text_field("Slug"), with: "new-post")
    |> click(button("Save"))
    |> assert_has(css(".alert-info", text: "Post created successfully."))

    session
    |> visit("/")
    |> click(link("Blog"))
    |> assert_has(css("td", text: "New Post"))
  end
end
