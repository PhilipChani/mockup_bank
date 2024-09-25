defmodule MockupBank.Repo.Migrations.AccountUsers do
  use Ecto.Migration

  def change do

    create table(:account_users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :role, :string, null: false

      timestamps()
    end

    create unique_index(:account_users, [:email])

    create table(:user_accounts) do
      add :account_number, :string, null: false
      add :balance, :decimal, null: false, precision: 10, scale: 2
      add :currency, :string, null: false
      add :account_type, :string, null: false
      add :status, :string, null: false
      add :last_transaction_date, :naive_datetime
      add :account_users_id, references(:account_users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:user_accounts, [:account_number])
    create index(:user_accounts, [:account_users_id])

    create table(:transactions) do
      add :type, :string, null: false
      add :amount, :decimal, null: false, precision: 10, scale: 2
      add :description, :string
      add :status, :string, null: false
      add :from_account_id, references(:user_accounts, on_delete: :restrict)
      add :to_account_id, references(:user_accounts, on_delete: :restrict)
      add :credit_amount, :decimal, null: false, precision: 10, scale: 2, default: 0
      add :debit_amount, :decimal, null: false, precision: 10, scale: 2, default: 0
      add :reference, :string, null: false
      add :value_date, :date, null: false
      add :opening_balance, :decimal, null: false, precision: 10, scale: 2
      add :closing_balance, :decimal, null: false, precision: 10, scale: 2

      timestamps()
    end

    create index(:transactions, [:from_account_id])
    create index(:transactions, [:to_account_id])
    create index(:transactions, [:type])
    create index(:transactions, [:status])

  end
end
