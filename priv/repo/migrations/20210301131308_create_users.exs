defmodule Sawo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false
      add :photo, :string
      add :address, :string
      add :gender, :string
      add :birthday, :date
      add :role_id, references(:roles, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:users, [:role_id])
  end
end
