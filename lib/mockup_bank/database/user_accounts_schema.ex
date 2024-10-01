defmodule MockupBank.Database.UserAccounts do
  @moduledoc """
  This module handles operations related to user accounts in the MockupBank database.

  It provides functions for creating, reading, updating, and deleting user account records,
  as well as performing various account-related operations such as balance inquiries,
  transfers, and transaction history.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:nickname, :account_number, :balance, :currency, :account_type, :status, :last_transaction_date, :hidden, :frozen, :enable_alerts, :low_balance_alert, :low_balance_threshold, :large_transaction_alert, :large_transaction_threshold, :suspicous_activity_alert, :suspicous_activity_seconds_between_transactions]}
  schema "user_accounts" do
    field :nickname, :string
    field :account_number, :string
    field :balance, :decimal
    field :currency, :string
    field :account_type, :string
    field :status, :string
    field :last_transaction_date, :naive_datetime


    field :hidden, :boolean, default: false
    field :frozen, :boolean, default: false
    field :enable_alerts, :boolean, default: true

    field :low_balance_alert, :boolean, default: false
    field :low_balance_threshold, :decimal, default: 0.0

    field :large_transaction_alert, :boolean, default: false
    field :large_transaction_threshold, :decimal, default: 0.0

    field :suspicous_activity_alert, :boolean, default: false
    field :suspicous_activity_seconds_between_transactions, :integer, default: 0


    belongs_to :account_users, MockupBank.Database.AccountUsers

    timestamps()
  end

  def changeset(user_account, attrs) do
    user_account
    |> cast(attrs, [:nickname, :account_users_id, :account_number, :balance, :currency, :account_type, :status, :last_transaction_date])
    |> validate_required([:account_number, :balance, :currency, :account_type, :status])
    |> unique_constraint(:account_number)
  end

end
