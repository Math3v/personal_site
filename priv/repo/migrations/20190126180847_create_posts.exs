defmodule PersonalSite.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :tags, {:array, :string}
      add :slug, :string

      timestamps()
    end
  end
end
