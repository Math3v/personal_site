defmodule PersonalSite.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :slug, :string
    field :tags, {:array, :string}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :tags, :slug])
    |> validate_required([:title, :body, :tags, :slug])
  end
end
