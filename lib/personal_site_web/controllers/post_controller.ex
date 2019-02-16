defmodule PersonalSiteWeb.PostController do
  use PersonalSiteWeb, :controller

  alias PersonalSite.Blog
  alias PersonalSite.Blog.Post

  def index(conn, _params) do
    with nil <- Guardian.Plug.current_resource(conn) do
      posts = Blog.list_published_posts()
      render(conn, "index.html", posts: posts)
    else
      _ ->
        posts = Blog.list_posts()
        render(conn, "index.html", posts: posts)
    end
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.auth_post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post_by_slug!(id)

    conn
    |> assign(:title, post.title)
    |> render("show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post_by_slug!(id)
    changeset = Blog.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post_by_slug!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.auth_post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post_by_slug!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.auth_post_path(conn, :index))
  end

  def publish(conn, %{"id" => id}) do
    {:ok, _post} = Blog.publish_post_by_slug(id)

    conn
    |> put_flash(:info, "Post published successfully.")
    |> redirect(to: Routes.auth_post_path(conn, :index))
  end
end
