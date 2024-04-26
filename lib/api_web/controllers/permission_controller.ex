defmodule ApiWeb.PermissionController do
  use ApiWeb, :controller

  def binary_value_by_permissions(conn, %{"permissions" => permissions}) do
    {binary_value, equation} = Api.Permission.binary_value_by_permissions(permissions)
    json(conn, %{binary_value: binary_value, equation: equation})
  end

  def permissions_by_binary_value(conn, %{"binary_value" => binary_value}) do
    binary_value = String.to_integer(binary_value)
    permissions = Api.Permission.permissions_by_binary_value(binary_value)
    json(conn, %{permissions: permissions})
  end

  def get_permissions_list(conn, _params) do
    permissions = Api.Permission.get_permissions_list()
    json(conn, %{permissions: permissions})
  end
end
