defmodule Api.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :id, :string, primary_key: true, null: false
      add :name, :string
      add :permissions, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
