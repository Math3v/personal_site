use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :personal_site, PersonalSiteWeb.Endpoint,
  http: [port: 4002],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :personal_site, PersonalSite.Repo,
  username: System.get_env("DATABASE_POSTGRESQL_USERNAME") || "postgres",
  password: System.get_env("DATABASE_POSTGRESQL_PASSWORD") || "postgres",
  database: "personal_site_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
