defmodule PersonalSite.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias PersonalSite.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import PersonalSiteWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PersonalSite.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PersonalSite.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(PersonalSite.Repo, self())

    {:ok, session} = Wallaby.start_session(metadata: metadata)

    {:ok, session: session}
  end
end
