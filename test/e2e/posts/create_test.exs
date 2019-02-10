defmodule PersonalSite.Posts.CreateTest do
  use PersonalSite.IntegrationCase

  import Wallaby.Query, only: [css: 2, link: 1]
  import PersonalSiteWeb.IntegrationAuthHelper, only: [login_admin: 1]
  import PersonalSiteWeb.IntegrationPostHelper, only: [create_post: 1]

  test "creates post and navigates to index", %{session: session} do
    session
    |> login_admin()
    |> click(link("Blog"))
    |> assert_has(css("a", text: "New Post"))
  end

  test "access post via slug", %{session: session} do
    session
    |> create_post()
    |> visit("/posts/new-post")
    |> assert_has(css("h1", text: "New Post"))
  end

  test "creates draft and publishes it", %{session: session} do
    session
    |> login_admin()
    |> create_post()
    |> visit("/posts")
    |> assert_has(css(".title.is-1", count: 0))
  end
end
