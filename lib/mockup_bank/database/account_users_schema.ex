defmodule MockupBank.Database.AccountUsers do
  @moduledoc """
  This module handles operations related to user accounts in the MockupBank database.

  It provides functions for creating, reading, updating, and deleting user account records,
  as well as performing various account-related operations such as balance inquiries,
  transfers, and transaction history.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:email, :name, :first_name, :last_name, :phone, :date_of_birth, :address, :city, :state, :zip, :country, :region, :postal_code, :identifier_type, :identifier_number, :currency, :role]}
  schema "account_users" do
    field :email, :string
    field :name, :string
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :date_of_birth, :date
    field :address, :string
    field :city, :string
    field :state, :string
    field :zip, :string
    field :country, :string
    field :region, :string
    field :postal_code, :string
    field :identifier_type, :string
    field :identifier_number, :string
    field :currency, :string
    field :role, :string
    has_many :user_accounts, MockupBank.Database.UserAccounts

    timestamps()
  end

  def changeset(account_user, attrs) do
    account_user
    |> cast(attrs, [:email, :name, :first_name, :last_name, :phone, :date_of_birth, :address, :city, :state, :zip, :country, :region, :postal_code, :identifier_type, :identifier_number, :currency, :role])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end

end
