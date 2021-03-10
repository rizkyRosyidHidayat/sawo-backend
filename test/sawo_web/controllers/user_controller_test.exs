defmodule SawoWeb.UserControllerTest do
  use SawoWeb.ConnCase

  alias Sawo.Users
  alias Sawo.Users.User

  @create_attrs %{
    address: "some address",
    birthday: ~D[2010-04-17],
    email: "some email",
    gender: "some gender",
    password: "some password",
    photo: "some photo",
    username: "some username"
  }
  @update_attrs %{
    address: "some updated address",
    birthday: ~D[2011-05-18],
    email: "some updated email",
    gender: "some updated gender",
    password: "some updated password",
    photo: "some updated photo",
    username: "some updated username"
  }
  @invalid_attrs %{address: nil, birthday: nil, email: nil, gender: nil, password: nil, photo: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Users.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "birthday" => "2010-04-17",
               "email" => "some email",
               "gender" => "some gender",
               "password" => "some password",
               "photo" => "some photo",
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some updated address",
               "birthday" => "2011-05-18",
               "email" => "some updated email",
               "gender" => "some updated gender",
               "password" => "some updated password",
               "photo" => "some updated photo",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
