defmodule PersonalSite.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias PersonalSite.Repo

  alias PersonalSite.Accounts.Admin
  alias Comeonin.Bcrypt

  @doc """
  Returns the list of admins.

  ## Examples

      iex> list_admins()
      [%Admin{}, ...]

  """
  def list_admins do
    Repo.all(Admin)
  end

  @doc """
  Gets a single admin.

  Raises `Ecto.NoResultsError` if the Admin does not exist.

  ## Examples

      iex> get_admin!(123)
      %Admin{}

      iex> get_admin!(456)
      ** (Ecto.NoResultsError)

  """
  def get_admin!(id), do: Repo.get!(Admin, id)

  @doc """
  Creates a admin.

  ## Examples

      iex> create_admin(%{field: value})
      {:ok, %Admin{}}

      iex> create_admin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admin(attrs \\ %{}) do
    %Admin{}
    |> Admin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a admin.

  ## Examples

      iex> update_admin(admin, %{field: new_value})
      {:ok, %Admin{}}

      iex> update_admin(admin, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_admin(%Admin{} = admin, attrs) do
    admin
    |> Admin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Admin.

  ## Examples

      iex> delete_admin(admin)
      {:ok, %Admin{}}

      iex> delete_admin(admin)
      {:error, %Ecto.Changeset{}}

  """
  def delete_admin(%Admin{} = admin) do
    Repo.delete(admin)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking admin changes.

  ## Examples

      iex> change_admin(admin)
      %Ecto.Changeset{source: %Admin{}}

  """
  def change_admin(%Admin{} = admin) do
    Admin.changeset(admin, %{})
  end

  def authenticate_admin(username, plain_text_password) do
    query = from a in Admin, where: a.username == ^username

    case Repo.one(query) do
      nil ->
        Bcrypt.dummy_checkpw()
        {:error, :invalid_credentials}

      admin ->
        # if Bcrypt.checkpw(plain_text_password, admin.password) do
        if Bcrypt.check_pass(plain_text_password, admin.password) do
          {:ok, admin}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
