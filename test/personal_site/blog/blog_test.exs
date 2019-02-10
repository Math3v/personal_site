defmodule PersonalSite.BlogTest do
  use PersonalSite.DataCase

  alias PersonalSite.Blog

  describe "posts" do
    alias PersonalSite.Blog.Post

    @valid_attrs %{body: "some body", slug: "some slug", tags_input: "react", title: "some title"}
    @update_attrs %{
      body: "some updated body",
      slug: "some updated slug",
      tags_input: "elixir",
      title: "some updated title"
    }
    @invalid_attrs %{body: nil, slug: nil, tags_input: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [%{post | tags_input: nil}]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == %{post | tags_input: nil}
    end

    test "get_post_by_slug!/1 returns the post with given slug" do
      post = post_fixture()
      assert Blog.get_post_by_slug!(post.slug) == %{post | tags_input: nil}
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.slug == "some-title"
      assert post.tags == ["react"]
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blog.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.slug == "some-updated-title"
      assert post.tags == ["elixir"]
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert %{post | tags_input: nil} == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end

    test "list_published_posts/0 returns published" do
      {:ok, published_at} = DateTime.now("Etc/UTC")
      published_post = post_fixture(%{published_at: published_at})
      post_fixture(%{title: "Title 2"})

      assert Blog.list_published_posts() == [%{published_post | tags_input: nil}]
    end
  end
end
