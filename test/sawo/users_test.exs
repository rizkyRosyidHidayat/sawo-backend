defmodule Sawo.UsersTest do
  use Sawo.DataCase

  alias Sawo.Users

  describe "users" do
    alias Sawo.Users.User

    @valid_attrs %{address: "some address", birthday: ~D[2010-04-17], email: "some email", gender: "some gender", password: "some password", photo: "some photo", username: "some username"}
    @update_attrs %{address: "some updated address", birthday: ~D[2011-05-18], email: "some updated email", gender: "some updated gender", password: "some updated password", photo: "some updated photo", username: "some updated username"}
    @invalid_attrs %{address: nil, birthday: nil, email: nil, gender: nil, password: nil, photo: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.address == "some address"
      assert user.birthday == ~D[2010-04-17]
      assert user.email == "some email"
      assert user.gender == "some gender"
      assert user.password == "some password"
      assert user.photo == "some photo"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.address == "some updated address"
      assert user.birthday == ~D[2011-05-18]
      assert user.email == "some updated email"
      assert user.gender == "some updated gender"
      assert user.password == "some updated password"
      assert user.photo == "some updated photo"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
