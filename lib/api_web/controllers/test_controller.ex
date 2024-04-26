defmodule ApiWeb.TestController do
  use ApiWeb, :controller

  def test_permissions(conn, %{"role" => role}) do
    role = Api.Roles.get_role_by_name!(role)
    can_manage_roles = Api.Permission.can?(role.permissions, :manage_roles) or Api.Permission.can?(role.permissions, :administrator)
    json(conn, %{can_manage_roles: can_manage_roles})
  end
end
