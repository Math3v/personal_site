defmodule PersonalSite.Repo do
  use Ecto.Repo,
    otp_app: :personal_site,
    adapter: Ecto.Adapters.Postgres
end
