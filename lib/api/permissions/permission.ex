defmodule Api.Permission do
  @permissions %{
    "create_invite" => 0x1,
    "send_messages" => 0x10,
    "administrator" => 0x8,
    "manage_webhooks" => 0x20000000,
    "manage_space" => 0x20,
    "manage_roles" => 0x10000000
  }

  def get_permissions_list() do
    Enum.map(@permissions, fn {permission, _} -> permission end)
  end

  def binary_value_by_permissions(permission_names) do
    {binary_value, equation} = permission_names
    |> Enum.map(&{Map.get(@permissions, &1, 0), &1})
    |> Enum.reduce({0, ""}, fn {value, _}, {acc_value, acc_equation} ->
      {Bitwise.bor(value, acc_value), acc_equation <> (if acc_equation != "", do: " | ", else: "") <> "0x#{Integer.to_string(value, 16)}"}
    end)

    {binary_value, equation}
  end

  def permissions_by_binary_value(binary_value) do
    @permissions
    |> Enum.filter(fn {_, value} -> Bitwise.band(binary_value, value) == value end)
    |> Enum.map(fn {permission, _} -> permission end)
  end

  def can?(role_permissions, required_permissions) do
    role_permissions = role_permissions |> Integer.to_string() |> String.to_integer()
    required_permissions = Atom.to_string(required_permissions)
    permissions = permissions_by_binary_value(role_permissions)
    can = Enum.member?(permissions, required_permissions)
    can
  end
end
