defmodule MockupBank.Database.UserAccounts do
  @moduledoc """
  This module handles operations related to user accounts in the MockupBank database.

  It provides functions for creating, reading, updating, and deleting user account records,
  as well as performing various account-related operations such as balance inquiries,
  transfers, and transaction history.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:account_number, :balance, :currency, :account_type, :status, :last_transaction_date]}
  schema "user_accounts" do
    field :account_number, :string
    field :balance, :decimal
    field :currency, :string
    field :account_type, :string
    field :status, :string
    field :last_transaction_date, :naive_datetime
    belongs_to :account_users, MockupBank.Database.AccountUsers

    timestamps()
  end

  def changeset(user_account, attrs) do
    user_account
    |> cast(attrs, [:account_users_id, :account_number, :balance, :currency, :account_type, :status, :last_transaction_date])
    |> validate_required([:account_number, :balance, :currency, :account_type, :status])
    |> unique_constraint(:account_number)
  end

end
