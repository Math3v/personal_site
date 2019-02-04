defmodule PersonalSite.Repo.Migrations.AddUniqueIndexToPostSlug do
  use Ecto.Migration

  def change do
    create unique_index(:posts, [:slug])
  end
end
