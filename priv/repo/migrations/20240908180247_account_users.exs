defmodule MockupBank.Repo.Migrations.AccountUsers do
  use Ecto.Migration

  def change do

    create table(:account_users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :customer_number, :string
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :date_of_birth, :date
      add :address, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :country, :string
      add :region, :string
      add :postal_code, :string
      add :identifier_type, :string
      add :identifier_number, :string
      add :currency, :string
      add :role, :string, null: false

      add :notify_sms, :boolean, default: true
      add :notify_email, :boolean, default: true
      add :push_notifications, :boolean, default: true

      timestamps()
    end

    create unique_index(:account_users, [:email])

    create table(:user_accounts) do
      add :nickname, :string
      add :account_number, :string, null: false
      add :balance, :decimal, null: false, precision: 10, scale: 2
      add :currency, :string, null: false
      add :account_type, :string, null: false
      add :status, :string, null: false
      add :last_transaction_date, :naive_datetime
      add :account_users_id, references(:account_users, on_delete: :delete_all), null: false
      add :hidden, :boolean, default: false
      add :frozen, :boolean, default: false
      add :enable_alerts, :boolean, default: true
      add :low_balance_alert, :boolean, default: false
      add :low_balance_threshold, :decimal, default: 0.0, precision: 10, scale: 2
      add :large_transaction_alert, :boolean, default: false
      add :large_transaction_threshold, :decimal, default: 0.0, precision: 10, scale: 2
      add :suspicous_activity_alert, :boolean, default: false
      add :suspicous_activity_seconds_between_transactions, :integer, default: 0
      add :account_creation_date, :naive_datetime
      add :account_closure_date, :naive_datetime
      add :account_closure_reason, :string
      add :joint_account, :boolean, default: false
      add :joint_account_holder_id, references(:account_users, on_delete: :delete_all)
      add :overdraft_limit, :decimal, default: 0.0, precision: 10, scale: 2
      add :overdraft_protection, :boolean, default: false
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
