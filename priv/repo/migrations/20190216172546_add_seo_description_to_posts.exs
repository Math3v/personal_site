defmodule PersonalSite.Repo.Migrations.AddSeoDescriptionToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :seo_description, :string
    end
  end
end
