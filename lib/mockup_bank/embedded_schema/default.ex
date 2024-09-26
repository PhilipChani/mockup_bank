defmodule MockupBank.EmbeededSchema.Default do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
      field :email, :string
      field :name, :string
      field :initial_balance, :string
      field :currency, :string
      field :account_type, :string
      field :account_number, :string
    end
  
    @doc false
    def changeset(actions, attrs \\ %{}) do
      actions
      |> cast(attrs, [:email, :name, :account_number, :account_type, :initial_balance, :currency])
    end

    def change(params \\ %{}) do
        %MockupBank.EmbeededSchema.Default{}
        |> MockupBank.EmbeededSchema.Default.changeset(params)
    end
  end