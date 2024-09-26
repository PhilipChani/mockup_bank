defmodule MockupBank.Service.TransactionService do
  # Import necessary modules and aliases
  alias MockupBank.Repo
  alias MockupBank.Database.{UserAccounts, AccountUsers, Transaction}
  import Ecto.Query

  # Function to create a new account
  def create_account(params) do

    params = Enum.into(params, %{}, fn {k, v} -> {String.to_atom(k), v} end)
    %{email: email, name: name, initial_balance: initial_balance, currency: currency, account_type: account_type} = params

    # Start a database transaction
    Repo.transaction(fn ->
      # Attempt to find or create an account user, then create an account, and finally create an initial deposit transaction
      with {:ok, account_user} <- find_or_create_account_user(email, name, params),
           {:ok, user_account} <- do_create_account(account_user, initial_balance, currency, account_type),
           {:ok, _transaction} <- create_transaction(nil, user_account, initial_balance, "initial_deposit") do
        # Return the created user account if all operations succeed
        user_account
      else
        # Rollback the transaction if any operation fails
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end) |> IO.inspect
  end

  # Function to credit an account
  def credit_account(account_number, amount, description \\ "Credit") do
    # Start a database transaction
    {:ok, response} = Repo.transaction(fn ->
      # Attempt to get the account by its number, update its balance, and create a credit transaction
      with %UserAccounts{} = account <- get_account_by_number(account_number),
           {:ok, updated_account} <- do_update_balance(account, Decimal.add(account.balance, Decimal.new(amount))),
           {:ok, transaction} <- create_transaction(nil, account, amount, description) do
        # Return the updated account and the transaction if all operations succeed
        {updated_account, transaction}
      else
        # Rollback the transaction if the account is not found or any operation fails
        nil -> Repo.rollback(:account_not_found)
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)

    response
  end

  # Function to debit an account
  def debit_account(account_number, amount, description \\ "Debit") do
    # Start a database transaction
    {:ok, response} = Repo.transaction(fn ->
      # Attempt to get the account by its number, check sufficient balance, update its balance, and create a debit transaction
      with %UserAccounts{} = account <- get_account_by_number(account_number),
           :ok <- check_sufficient_balance(account, amount),
           {:ok, updated_account} <- do_update_balance(account, Decimal.sub(account.balance, Decimal.new(amount))),
           {:ok, transaction} <- create_transaction(account, nil, amount, description) do
        # Return the updated account and the transaction if all operations succeed
        {updated_account, transaction}
      else
        # Rollback the transaction if the account is not found, insufficient funds, or any operation fails
        nil -> Repo.rollback(:account_not_found)
        {:error, :insufficient_funds} -> Repo.rollback(:insufficient_funds)
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)

    response
  end

  # Function to lookup accounts by email
  def lookup_accounts_by_email(email) do
    # Query the AccountUsers table to find accounts by email and preload associated user accounts
    AccountUsers
    |> where([au], au.email == ^email)
    |> preload(:user_accounts)
    |> Repo.one()
  end

  # Function to transfer funds between accounts
  def transfer_funds(from_account_number, to_account_number, amount, description \\ "Transfer") do
    # Start a database transaction
    Repo.transaction(fn ->
      # Attempt to get both accounts by their numbers, check sufficient balance, update balances, and create a transfer transaction
      with %UserAccounts{} = from_account <- get_account_by_number(from_account_number),
           %UserAccounts{} = to_account <- get_account_by_number(to_account_number),
           :ok <- check_sufficient_balance(from_account, amount),
           {:ok, updated_from_account} <- do_update_balance(from_account, Decimal.sub(from_account.balance, Decimal.new(amount))),
           {:ok, updated_to_account} <- do_update_balance(to_account, Decimal.add(to_account.balance, Decimal.new(amount))),
           {:ok, transaction} <- create_transaction(from_account, to_account, amount, description) do
        # Return the updated accounts and the transaction if all operations succeed
        {updated_from_account, updated_to_account, transaction}
      else
        # Rollback the transaction if any account is not found, insufficient funds, or any operation fails
        nil -> Repo.rollback(:account_not_found)
        {:error, :insufficient_funds} -> Repo.rollback(:insufficient_funds)
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)
  end

  # Function to get transactions for an account
  def get_account_transactions(account_number) do
    # Get the account by its number
    account = get_account_by_number(account_number)

    # If the account exists, query the transactions table for transactions involving the account
    if account do
      Transaction
      |> where([t], t.from_account_id == ^account.id or t.to_account_id == ^account.id)
      |> order_by([t], desc: t.inserted_at)
      |> Repo.all()
    else
      # Return an empty list if the account does not exist
      []
    end
  end

  # Function to get an account by its number
  def get_by_account_number(account_number) do
    # Call the private function to get the account by its number
    get_account_by_number(account_number)
  end

  # Private function to find or create an account user
  defp find_or_create_account_user(email, name, params \\ %{}) do
    # Attempt to get the account user by email
    case Repo.get_by(AccountUsers, email: email) do
      # If the account user does not exist, create a new account user
      nil -> create_account_user(email, name, params)
      # If the account user exists, return it
      account_user -> {:ok, account_user}
    end
  end

  # Private function to create an account user
  defp create_account_user(_email, _name, params) do

    # Create a new AccountUsers struct and insert it into the database
    %AccountUsers{}
    |> AccountUsers.changeset(params)
    |> Repo.insert()
  end

  # Private function to create an account
  defp do_create_account(account_user, initial_balance, currency, account_type) do
    # Create a new UserAccounts struct and insert it into the database
    %UserAccounts{}
    |> UserAccounts.changeset(%{
      account_number: generate_account_number(),
      balance: initial_balance,
      currency: currency,
      account_type: account_type,
      status: "active",
      account_users_id: account_user.id
    })
    |> Repo.insert()
  end

  # Private function to get an account by its number
  defp get_account_by_number(account_number) do
    # Query the UserAccounts table to get the account by its number
    Repo.get_by(UserAccounts, account_number: account_number)
    |> Repo.preload([:account_users, account_users: :user_accounts])

  end

  # Private function to update the balance of an account
  defp do_update_balance(account, new_balance) do
    # Update the balance and last transaction date of the account
    account
    |> UserAccounts.changeset(%{balance: new_balance, last_transaction_date: NaiveDateTime.utc_now()})
    |> Repo.update()
  end

  # Private function to check if an account has sufficient balance
  defp check_sufficient_balance(account, amount) do
    # Compare the account balance with the amount to check for sufficient funds
    if Decimal.compare(account.balance, Decimal.new(amount)) == :lt do
      # Return an error if the balance is insufficient
      {:error, :insufficient_funds}
    else
      # Return :ok if the balance is sufficient
      :ok
    end
  end

  # Private function to create a transaction
  defp create_transaction(from_account, to_account, amount, description) do
    # Determine the type of transaction based on the presence of from_account and to_account
    transaction_type = determine_transaction_type(from_account, to_account)

    # Define the attributes for the new transaction
    attrs = %{
      type: transaction_type,
      amount: amount,
      description: description,
      status: "completed",
      from_account_id: from_account && from_account.id,
      to_account_id: to_account && to_account.id,
      credit_amount: if(transaction_type in ["credit", "transfer"], do: amount, else: Decimal.new(0)),
      debit_amount: if(transaction_type in ["debit", "transfer"], do: amount, else: Decimal.new(0)),
      reference: generate_reference(),
      value_date: Date.utc_today(),
      opening_balance: get_opening_balance(from_account || to_account),
      closing_balance: get_closing_balance(from_account || to_account, amount, transaction_type)
    }

    # Create a new Transaction struct and insert it into the database
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  # Private function to determine the type of transaction
  defp determine_transaction_type(nil, _to_account), do: "credit"
  defp determine_transaction_type(_from_account, nil), do: "debit"
  defp determine_transaction_type(_from_account, _to_account), do: "transfer"

  # Private function to generate a unique account number
  def generate_account_number do
    # Generate a unique account number using timestamp, date and 12 random numbers

    number = :rand.uniform(999999)
    |> Integer.to_string()

    "1850000#{String.slice(number, 0, 6)}"
  end

  # Private function to generate a unique transaction reference
  defp generate_reference do
    # Generate a unique transaction reference using random bytes
    "TXN" <> (:crypto.strong_rand_bytes(8) |> Base.encode16())
  end

  # Private function to get the opening balance of an account
  defp get_opening_balance(account) do
    # Return the current balance of the account
    account.balance
  end

  # Private function to get the closing balance of an account
  defp get_closing_balance(account, amount, transaction_type) do
    amount = Decimal.new(to_string(amount))

    case transaction_type do
      "credit" -> Decimal.add(account.balance, amount)
      "debit" -> Decimal.sub(account.balance, amount)
      "transfer" -> account.balance
    end
  end
end
