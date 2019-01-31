{:ok, _} = Application.ensure_all_started(:wallaby)
{:ok, _} = Application.ensure_all_started(:ex_machina)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(PersonalSite.Repo, :manual)

Application.put_env(:wallaby, :base_url, PersonalSiteWeb.Endpoint.url())
