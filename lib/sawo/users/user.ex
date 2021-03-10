defmodule Sawo.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sawo.Roles.Role

  schema "users" do
    field :address, :string
    field :birthday, :date
    field :email, :string
    field :gender, :string
    field :password, :string
    field :photo, :string
    field :username, :string
    belongs_to(:role, Role)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :photo, :address, :gender, :birthday, :role_id])
    |> validate_required([:username, :email, :password, :photo, :address, :gender, :birthday, :role_id])
    |> assoc_constraint(:role)
  end
end
