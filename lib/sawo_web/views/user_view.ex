defmodule SawoWeb.UserView do
  use SawoWeb, :view
  alias SawoWeb.{UserView}

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      password: user.password,
      photo: user.photo,
      address: user.address,
      gender: user.gender,
      birthday: user.birthday,
      role_id: user.role_id
    }
  end
end
