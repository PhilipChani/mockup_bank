defmodule MockupBank.Database.AccountUsers do
  @moduledoc """
  This module handles operations related to user accounts in the MockupBank database.

  It provides functions for creating, reading, updating, and deleting user account records,
  as well as performing various account-related operations such as balance inquiries,
  transfers, and transaction history.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "account_users" do
    field :email, :string
    field :name, :string
    field :role, :string
    has_many :user_accounts, MockupBank.Database.UserAccounts

    timestamps()
  end

  def changeset(account_user, attrs) do
    account_user
    |> cast(attrs, [:email, :name, :role])
    |> validate_required([:email, :name, :role])
    |> unique_constraint(:email)
  end

end
