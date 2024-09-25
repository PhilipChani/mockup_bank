defmodule MockupBank.Repo.Migrations.UserAccounts do
  use Ecto.Migration

  def change do
  #   create table(:user_accounts) do
  #     add :account_number, :string, null: false
  #     add :balance, :decimal, null: false, precision: 10, scale: 2
  #     add :currency, :string, null: false
  #     add :account_type, :string, null: false
  #     add :status, :string, null: false
  #     add :last_transaction_date, :naive_datetime
  #     add :account_user_id, references(:account_users, on_delete: :delete_all), null: false

  #     timestamps()
  #   end

  #   create unique_index(:user_accounts, [:account_number])
  #   create index(:user_accounts, [:account_user_id])
  end

end
