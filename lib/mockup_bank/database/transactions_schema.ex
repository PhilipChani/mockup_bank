defmodule MockupBank.Database.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :type, :string
    field :amount, :decimal
    field :description, :string
    field :status, :string
    belongs_to :from_account, MockupBank.Database.UserAccount
    belongs_to :to_account, MockupBank.Database.UserAccount

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:type, :amount, :description, :status, :from_account_id, :to_account_id])
    |> validate_required([:type, :amount, :status])
    |> validate_inclusion(:type, ["credit", "debit", "transfer"])
    |> validate_inclusion(:status, ["pending", "completed", "failed"])
    |> validate_number(:amount, greater_than: 0)
    |> foreign_key_constraint(:from_account_id)
    |> foreign_key_constraint(:to_account_id)
  end
end
