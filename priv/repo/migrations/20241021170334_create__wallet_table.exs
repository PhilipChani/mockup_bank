defmodule MockupBank.Repo.Migrations.Create_WalletTable do
  use Ecto.Migration

  def change do
    create table(:wallet_accounts) do
      add :nickname, :string
      add :account_number, :string, null: false
      add :customer_number, :string
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

    create unique_index(:wallet_accounts, [:account_number])
    create index(:wallet_accounts, [:account_users_id])
  end
end
