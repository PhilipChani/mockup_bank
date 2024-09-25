defmodule MockupBank.Database.Transaction do
  use Ecto.Schema  # Use the Ecto.Schema module to define the schema for the Transaction model
  import Ecto.Changeset  # Import the Ecto.Changeset module to handle changesets

  schema "transactions" do  # Define the schema for the "transactions" table
    field :type, :string  # Define a string field for the type of transaction (e.g., credit, debit, transfer)
    field :amount, :decimal  # Define a decimal field for the transaction amount
    field :credit_amount, :decimal  # Define a decimal field for the credit amount
    field :debit_amount, :decimal  # Define a decimal field for the debit amount
    field :description, :string  # Define a string field for the transaction description
    field :status, :string  # Define a string field for the transaction status (e.g., pending, completed, failed)
    field :reference, :string  # Define a string field for the transaction reference
    field :value_date, :date  # Define a date field for the value date of the transaction
    field :opening_balance, :decimal  # Define a decimal field for the opening balance before the transaction
    field :closing_balance, :decimal  # Define a decimal field for the closing balance after the transaction
    belongs_to :from_account, MockupBank.Database.UserAccount  # Define a belongs_to association with the UserAccount model for the from_account
    belongs_to :to_account, MockupBank.Database.UserAccount  # Define a belongs_to association with the UserAccount model for the to_account

    timestamps()  # Automatically manage inserted_at and updated_at timestamp fields
  end

  @doc false  # Indicate that this function is for internal use and should not be included in the generated documentation
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:type, :amount, :credit_amount, :debit_amount, :description, :status, :reference, :from_account_id, :to_account_id, :value_date, :opening_balance, :closing_balance])  # Cast the given attributes to the transaction struct
    |> validate_required([:type, :amount, :status, :value_date, :opening_balance, :closing_balance])  # Validate that the required fields are present
    |> validate_inclusion(:type, ["credit", "debit", "transfer"])  # Validate that the type field is one of the allowed values
    |> validate_inclusion(:status, ["pending", "completed", "failed"])  # Validate that the status field is one of the allowed values
    |> validate_number(:amount, greater_than: 0)  # Validate that the amount is greater than 0
    |> validate_number(:credit_amount, greater_than_or_equal_to: 0)  # Validate that the credit amount is greater than or equal to 0
    |> validate_number(:debit_amount, greater_than_or_equal_to: 0)  # Validate that the debit amount is greater than or equal to 0
    |> validate_number(:opening_balance, greater_than_or_equal_to: 0)  # Validate that the opening balance is greater than or equal to 0
    |> validate_number(:closing_balance, greater_than_or_equal_to: 0)  # Validate that the closing balance is greater than or equal to 0
    |> foreign_key_constraint(:from_account_id)  # Ensure that the from_account_id field references a valid UserAccount
    |> foreign_key_constraint(:to_account_id)  # Ensure that the to_account_id field references a valid UserAccount
  end
end
