defmodule PersonalSiteWeb.PostControllerTest do
  use PersonalSiteWeb.ConnCase
  import PersonalSite.Accounts.Guardian
  import PersonalSite.Factory

  alias PersonalSite.Blog

  @create_attrs %{body: "some body", tags_input: "react", title: "some title", published_at: nil}
  @update_attrs %{
    body: "some updated body",
    tags_input: "elixir",
    title: "some updated title"
  }
  @invalid_attrs %{body: nil, slug: nil, tags_input: nil, title: nil}

  def fixture(:post, attrs \\ @create_attrs) do
    {:ok, post} = Blog.create_post(attrs)
    post
  end

  def login_admin(%{conn: conn}) do
    admin = insert(:admin)
    {:ok, token, _} = encode_and_sign(admin, %{}, token_type: :access)
    conn = put_req_header(conn, "authorization", "bearer: " <> token)
    %{conn: conn}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      {:ok, published_at} = DateTime.now("Etc/UTC")
      fixture(:post, %{@create_attrs | published_at: published_at})
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "some title"
    end
  end

  describe "new post" do
    setup [:login_admin]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.auth_post_path(conn, :new))
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    setup [:login_admin]

    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.auth_post_path(conn, :create), post: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.auth_post_path(conn, :show, id)

      conn = get(conn, Routes.post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "some title"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.auth_post_path(conn, :create), post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    setup [:create_post, :login_admin]

    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get(conn, Routes.auth_post_path(conn, :edit, post))
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post, :login_admin]

    test "redirects when data is valid", %{conn: conn, post: post} do
      conn = put(conn, Routes.auth_post_path(conn, :update, post), post: @update_attrs)
      assert redirected_to(conn) == "/auth/posts/some-updated-title"

      post = Blog.get_post_by_slug!("some-updated-title")
      conn = get(conn, Routes.post_path(conn, :show, post))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, Routes.auth_post_path(conn, :update, post), post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post, :login_admin]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.auth_post_path(conn, :delete, post))
      assert redirected_to(conn) == Routes.auth_post_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.post_path(conn, :show, post))
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    {:ok, post: post}
  end
end
