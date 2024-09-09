defmodule MockupBank.Service.TransactionService do
  alias MockupBank.Repo
  alias MockupBank.Database.{UserAccounts, AccountUsers, Transaction}
  import Ecto.Query

  def create_account(%{email: email, name: name, initial_balance: initial_balance, currency: currency, account_type: account_type}) do
    Repo.transaction(fn ->
      with {:ok, account_user} <- find_or_create_account_user(email, name) |> IO.inspect,
           {:ok, user_account} <- do_create_account(account_user, initial_balance, currency, account_type) |> IO.inspect,
           {:ok, _transaction} <- create_transaction(nil, user_account, initial_balance, "initial_deposit") do
        user_account
      else
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)
  end

  def credit_account(account_number, amount, description \\ "Credit") do
    Repo.transaction(fn ->
      with %UserAccounts{} = account <- get_account_by_number(account_number),
           {:ok, updated_account} <- do_update_balance(account, Decimal.add(account.balance, Decimal.new(amount))),
           {:ok, transaction} <- create_transaction(nil, account, amount, description) do
        {updated_account, transaction}
      else
        nil -> Repo.rollback(:account_not_found)
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)
  end

  def debit_account(account_number, amount, description \\ "Debit") do
    Repo.transaction(fn ->
      with %UserAccounts{} = account <- get_account_by_number(account_number),
           :ok <- check_sufficient_balance(account, amount),
           {:ok, updated_account} <- do_update_balance(account, Decimal.sub(account.balance, Decimal.new(amount))),
           {:ok, transaction} <- create_transaction(account, nil, amount, description) do
        {updated_account, transaction}
      else
        nil -> Repo.rollback(:account_not_found)
        {:error, :insufficient_funds} -> Repo.rollback(:insufficient_funds)
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)
  end

  def lookup_accounts_by_email(email) do
    AccountUsers
    |> where([au], au.email == ^email)
    |> preload(:user_accounts)
    |> Repo.one()
  end

  def transfer_funds(from_account_number, to_account_number, amount, description \\ "Transfer") do
    Repo.transaction(fn ->
      with %UserAccounts{} = from_account <- get_account_by_number(from_account_number),
           %UserAccounts{} = to_account <- get_account_by_number(to_account_number),
           :ok <- check_sufficient_balance(from_account, amount),
           {:ok, updated_from_account} <- do_update_balance(from_account, Decimal.sub(from_account.balance, Decimal.new(amount))),
           {:ok, updated_to_account} <- do_update_balance(to_account, Decimal.add(to_account.balance, Decimal.new(amount))),
           {:ok, transaction} <- create_transaction(from_account, to_account, amount, description) do
        {updated_from_account, updated_to_account, transaction}
      else
        nil -> Repo.rollback(:account_not_found)
        {:error, :insufficient_funds} -> Repo.rollback(:insufficient_funds)
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)
  end

  def get_account_transactions(account_number) do
    account = get_account_by_number(account_number)

    if account do
      Transaction
      |> where([t], t.from_account_id == ^account.id or t.to_account_id == ^account.id)
      |> order_by([t], desc: t.inserted_at)
      |> Repo.all()
    else
      []
    end
  end

  def get_by_account_number(account_number) do
    get_account_by_number(account_number)
  end

  # Private functions

  defp find_or_create_account_user(email, name) do
    case Repo.get_by(AccountUsers, email: email) do
      nil -> create_account_user(email, name)
      account_user -> {:ok, account_user}
    end
  end

  defp create_account_user(email, name) do
    %AccountUsers{}
    |> AccountUsers.changeset(%{email: email, name: name, role: "account_holder"})
    |> Repo.insert()
  end

  defp do_create_account(account_user, initial_balance, currency, account_type) do

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

  defp get_account_by_number(account_number) do
    Repo.get_by(UserAccounts, account_number: account_number)
  end

  defp do_update_balance(account, new_balance) do
    account
    |> UserAccounts.changeset(%{balance: new_balance, last_transaction_date: NaiveDateTime.utc_now()})
    |> Repo.update()
  end

  defp check_sufficient_balance(account, amount) do
    if Decimal.compare(account.balance, Decimal.new(amount)) == :lt do
      {:error, :insufficient_funds}
    else
      :ok
    end
  end

  defp create_transaction(from_account, to_account, amount, description) do
    %Transaction{}
    |> Transaction.changeset(%{
      type: determine_transaction_type(from_account, to_account),
      amount: amount,
      description: description,
      status: "completed",
      from_account_id: from_account && from_account.id,
      to_account_id: to_account && to_account.id
    })
    |> Repo.insert()
  end

  defp determine_transaction_type(nil, _to_account), do: "credit"
  defp determine_transaction_type(_from_account, nil), do: "debit"
  defp determine_transaction_type(_from_account, _to_account), do: "transfer"

  defp generate_account_number do
    "ACCT" <> (:crypto.strong_rand_bytes(8) |> Base.encode16())
  end
end
