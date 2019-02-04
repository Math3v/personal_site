defmodule PersonalSite.Posts.CreateTest do
  use PersonalSite.IntegrationCase

  import Wallaby.Query, only: [css: 2, text_field: 1, button: 1, link: 1]
  import PersonalSiteWeb.IntegrationAuthHelper, only: [login_admin: 1]

  def create_post(session) do
    session
    |> login_admin()
    |> visit("/posts/new")
    |> fill_in(text_field("Title"), with: "New Post")
    |> execute_script("document.getElementById('post_body').value = 'New Content';")
    |> fill_in(text_field("Tags input"), with: "elixir, erlang")
    |> click(button("Save"))
    |> assert_has(css(".message-body", text: "Post created successfully."))
  end

  test "creates post and navigates to index", %{session: session} do
    session
    |> create_post()
    |> visit("/")
    |> click(link("Blog"))
    |> assert_has(css("a", text: "New Post"))
  end

  test "access post via slug", %{session: session} do
    session
    |> create_post()
    |> visit("/posts/new-post")
    |> assert_has(css("h1", text: "New Post"))
  end
end
