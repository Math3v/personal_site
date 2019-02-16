defmodule PersonalSite.Posts.ShowTest do
  use PersonalSite.IntegrationCase

  import PersonalSiteWeb.IntegrationAuthHelper, only: [login_admin: 1]
  import PersonalSiteWeb.IntegrationPostHelper, only: [create_post: 1]

  test "has title and seo tags", %{session: session} do
    post_page =
      session
      |> login_admin()
      |> create_post()
      |> visit("/posts/new-post")

    title = post_page |> page_title()

    assert title == "New Post"
  end
end
