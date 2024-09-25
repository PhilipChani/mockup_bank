defmodule MockupBankWeb.Utilities.Permitted do
  @moduledoc """
  This module defines utility functions to check permissions based on user roles and actions.
  It is used to verify if a specific action is allowed for a user based on their role's rights.
  """

  @doc """
  Checks if a specific action is permitted for a user with a given role.

  ## Parameters
  - `role`: The role identifier as a string or atom.
  - `action`: The action identifier as a string or atom.
  - `user_role`: The `UserRole` struct containing the user's rights.

  ## Returns
  - `true` if the action is permitted.
  - `nil` if the user_role is nil, the role is not found, or the action is not permitted.

  ## Examples

      iex> MockupBankWeb.Utilities.Permitted.is_permitted?(:maintenance, :create, %UserRole{rights: %{admin: %{edit: true}}})
      true

      iex> MockupBankWeb.Utilities.Permitted.is_permitted?(:maintenance, :delete, %UserRole{rights: %{admin: %{edit: true}}})
      nil
  """
  def is_permitted?(role, action, user_role) do
    user_role
    |> get_rights_for_user_role
    |> check_role_permission(role)
    |> check_action_permission(action)
  end

  def action_definition(:new), do: :create
  def action_definition(:edit), do: :update
  def action_definition(:filter), do: :update
  def action_definition(action), do: action

  @doc false
  # Retrieves rights from the user_role struct or returns nil if user_role is nil.
  defp get_rights_for_user_role(nil), do: nil
  defp get_rights_for_user_role(user_role), do: Map.from_struct(user_role.rights)

  @doc false
  # Retrieves the rights for a specific role or returns nil if the role does not exist.
  defp check_role_permission(nil, _), do: nil

  defp check_role_permission(rights, role) do
    rights[role]
    |> Map.from_struct()
  end

  @doc false
  # Checks if the action is permitted within the given rights or returns nil if the action is not defined.
  defp check_action_permission(nil, _), do: nil
  defp check_action_permission(rights, action), do: rights[action]
end
