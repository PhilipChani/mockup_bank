defmodule MockupBankWeb.BankController do
  use MockupBankWeb, :controller
  alias MockupBank.Service.TransactionService, as: AccountTransactionService

  action_fallback MockupBankWeb.FallbackController

  def create_account(conn, %{"email" => email, "name" => name, "initial_balance" => initial_balance, "currency" => currency, "account_type" => account_type}) do
    with {:ok, account} <- AccountTransactionService.create_account(%{email: email, name: name, initial_balance: initial_balance, currency: currency, account_type: account_type}) do
      conn
      |> put_status(:created)
      |> render("account.json", account: account)
    end
  end

  def credit_account(conn, %{"account_number" => account_number, "amount" => amount} = params) do
    description = Map.get(params, "description", "Credit")
    with {updated_account , transaction} <- AccountTransactionService.credit_account(account_number, amount, description) do
      conn
      |> put_status(:ok)
      |> render("account_with_transaction.json", account: updated_account, transaction: transaction)
    end
  end

  def debit_account(conn, %{"account_number" => account_number, "amount" => amount} = params) do
    description = Map.get(params, "description", "Debit")
    with {updated_account, transaction} <- AccountTransactionService.debit_account(account_number, amount, description) do
      conn
      |> put_status(:ok)
      |> render("account_with_transaction.json", account: updated_account, transaction: transaction)
    end
  end

  def transfer_funds(conn, %{"from_account" => from_account, "to_account" => to_account, "amount" => amount} = params) do
    description = Map.get(params, "description", "Transfer")
    with {:ok, updated_from_account, updated_to_account, transaction} <- AccountTransactionService.transfer_funds(from_account, to_account, amount, description) do
      conn
      |> put_status(:ok)
      |> render("transfer_with_transaction.json", from: updated_from_account, to: updated_to_account, transaction: transaction)
    end
  end

  def lookup_accounts(conn, %{"email" => email}) do
    case AccountTransactionService.lookup_accounts_by_email(email) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "No accounts found for this email"})
      account_user ->
        conn
        |> put_status(:ok)
        |> render("account_user.json", account_user: account_user)
    end
  end

  def get_transactions(conn, %{"account_number" => account_number}) do
    transactions = AccountTransactionService.get_account_transactions(account_number)
    render(conn, "transactions.json", transactions: transactions)
  end

  def get_balance(conn, %{"account_number" => account_number}) do
    case AccountTransactionService.get_by_account_number(account_number) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Account not found"})
      account ->
        conn
        |> put_status(:ok)
        |> render("balance.json", account: account)
    end
  end


  def get_account(conn, %{"account_number" => account_number}) do
    case AccountTransactionService.get_by_account_number(account_number) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Account not found"})
      account ->

        IO.inspect account

        conn
        |> put_status(:ok)
        |> render("by_account_number.json", account: account)
    end
  end

end
