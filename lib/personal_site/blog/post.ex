defmodule PersonalSite.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :slug}
  schema "posts" do
    field :body, :string
    field :slug, :string
    field :tags, {:array, :string}
    field(:tags_input, :string, virtual: true)
    field :title, :string
    field :published_at, :utc_datetime
    field :seo_description, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :tags_input, :published_at, :seo_description])
    |> validate_required([:title, :body, :tags_input, :seo_description])
    |> tags_input_to_tags_array()
    |> title_to_slug()
  end

  defp tags_input_to_tags_array(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{tags_input: tags_input}} ->
        tags =
          tags_input
          |> String.split(",")
          |> Enum.map(&String.trim/1)

        put_change(changeset, :tags, tags)

      _ ->
        changeset
    end
  end

  defp title_to_slug(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{title: title}} ->
        slug =
          title
          |> String.downcase()
          |> String.replace(" ", "-")

        put_change(changeset, :slug, slug)

      _ ->
        changeset
    end
  end
end
