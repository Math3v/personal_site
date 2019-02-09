defmodule PersonalSiteWeb.IntegrationPostHelper do
  import Wallaby.Browser
  import Wallaby.Query, only: [css: 2, text_field: 1, button: 1]

  import PersonalSiteWeb.IntegrationAuthHelper, only: [login_admin: 1]

  def create_post(session) do
    session
    |> login_admin()
    |> visit("/auth/posts/new")
    |> fill_in(text_field("Title"), with: "New Post")
    |> execute_script("document.getElementById('post_body').value = 'New Content';")
    |> fill_in(text_field("Tags input"), with: "elixir, erlang")
    |> click(button("Save"))
    |> assert_has(css(".message-body", text: "Post created successfully."))
  end
end
