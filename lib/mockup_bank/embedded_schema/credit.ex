defmodule MockupBank.EmbeededSchema.Credit do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
      field :account_number, :string
      field :response, :string
      field :amount, :decimal
    end
  
    @doc false
    def changeset(actions, attrs \\ %{}) do
      actions
      |> cast(attrs, [:account_number, :response, :amount])
      |> validate_required([:account_number, :amount])
      |> validate_format(:account_number, ~r/^\d+$/, message: "invalid account combination")
      |> validate_number(:amount, greater_than: 0, message: "must be a positive number")
    end

    def change(params \\ %{}) do
        %MockupBank.EmbeededSchema.Credit{}
        |> MockupBank.EmbeededSchema.Credit.changeset(params)
    end
  end