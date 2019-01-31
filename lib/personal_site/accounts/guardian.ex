defmodule PersonalSite.Accounts.Guardian do
  use Guardian, otp_app: :personal_site

  alias PersonalSite.Accounts

  def subject_for_token(admin, _claims) do
    {:ok, to_string(admin.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_admin!(id) do
      nil -> {:error, :resource_not_found}
      admin -> {:ok, admin}
    end
  end
end
