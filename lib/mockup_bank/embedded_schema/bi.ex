defmodule MockupBank.EmbeededSchema.Bi do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
      field :account_number, :string
      field :response, :string
    end
  
    @doc false
    def changeset(actions, attrs \\ %{}) do
      actions
      |> cast(attrs, [:account_number, :response])
    end

    def change(params \\ %{}) do
        %MockupBank.EmbeededSchema.Bi{}
        |> MockupBank.EmbeededSchema.Bi.changeset(params)
    end
  end