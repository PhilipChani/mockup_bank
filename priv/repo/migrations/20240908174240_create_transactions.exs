mix defmodule MockupBank.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    # create table(:transactions) do
    #   add :type, :string, null: false
    #   add :amount, :decimal, null: false, precision: 10, scale: 2
    #   add :description, :string
    #   add :status, :string, null: false
    #   add :from_account_id, references(:user_accounts, on_delete: :restrict)
    #   add :to_account_id, references(:user_accounts, on_delete: :restrict)

    #   timestamps()
    # end

    # create index(:transactions, [:from_account_id])
    # create index(:transactions, [:to_account_id])
    # create index(:transactions, [:type])
    # create index(:transactions, [:status])
  end
end
