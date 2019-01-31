defmodule PersonalSite.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :personal_site,
    error_handler: PersonalSite.Accounts.ErrorHandler,
    module: PersonalSite.Accounts.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
