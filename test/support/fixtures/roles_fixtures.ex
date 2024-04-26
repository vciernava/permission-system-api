defmodule Api.RolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Roles` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name",
        permissions: %{}
      })
      |> Api.Roles.create_role()

    role
  end
end
