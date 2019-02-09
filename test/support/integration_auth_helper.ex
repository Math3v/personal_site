defmodule PersonalSiteWeb.IntegrationAuthHelper do
  alias PersonalSite.Accounts

  import PersonalSite.Factory
  import Wallaby.Browser
  import Wallaby.Query, only: [text_field: 1, button: 1]

  def login_admin(session) do
    admin_count = Accounts.list_admins() |> Enum.count()

    if admin_count == 0 do
      insert(:admin)
    end

    session
    |> visit("/login")
    |> fill_in(text_field("Username"), with: "admin")
    |> fill_in(text_field("Password"), with: "admin")
    |> click(button("Submit"))
  end
end
