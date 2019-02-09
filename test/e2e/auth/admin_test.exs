defmodule PersonalSite.Auth.AdminTest do
  use PersonalSite.IntegrationCase

  import Wallaby.Query, only: [css: 2, link: 1]
  import PersonalSiteWeb.IntegrationAuthHelper, only: [login_admin: 1]
  import PersonalSiteWeb.IntegrationPostHelper, only: [create_post: 1]

  test "admin navigates around the site", %{session: session} do
    session
    |> login_admin()
    |> click(link("Blog"))
    |> assert_has(css("a", text: "New Post"))

    session
    |> create_post()
    |> click(link("Blog"))
    |> assert_has(css("a", text: "Edit"))
    |> assert_has(css("a", text: "Delete"))
  end
end
