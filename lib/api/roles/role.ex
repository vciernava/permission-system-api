defmodule Api.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}
  @derive {Phoenix.Param, key: :id}
  schema "roles" do
    field :name, :string
    field :permissions, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:id, :name, :permissions])
    |> validate_required([:name])
    |> put_change(:id, generate_id())
  end

  defp generate_id() do
    :crypto.strong_rand_bytes(12)
    |> Base.url_encode64(padding: false)
    |> binary_part(0, 15)
  end
end
