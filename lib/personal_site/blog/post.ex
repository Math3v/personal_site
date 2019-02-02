defmodule PersonalSite.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :slug, :string
    field :tags, {:array, :string}
    field(:tags_input, :string, virtual: true)
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :tags_input, :slug])
    |> validate_required([:title, :body, :tags_input, :slug])
    |> tags_input_to_tags_array()
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
end
