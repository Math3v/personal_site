defmodule PersonalSite.Factory do
  use ExMachina.Ecto, repo: PersonalSite.Repo

  def admin_factory do
    %PersonalSite.Accounts.Admin{
      username: "admin",
      password: Bcrypt.hash_pwd_salt("admin")
    }
  end
end
