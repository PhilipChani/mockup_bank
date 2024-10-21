defmodule MockupBankWeb.WalletController do
  use MockupBankWeb, :controller
  alias MockupBank.Service.WalletService, as: AccountTransactionService

  action_fallback MockupBankWeb.FallbackController

  def create_account(conn, params) do
    with {:ok, account} <- AccountTransactionService.create_account(params) |> IO.inspect() do
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

  @spec transfer_funds(any(), map()) :: any()
  def transfer_funds(conn, %{"from_account" => from_account, "to_account" => to_account, "amount" => amount} = params) do
    description = Map.get(params, "description", "Transfer")
    with {:ok, {updated_from_account, updated_to_account, transaction}} <- AccountTransactionService.transfer_funds(from_account, to_account, amount, description) do
      conn
      |> put_status(:ok)
      |> render("transfer_with_transaction.json", from: updated_from_account, to: updated_to_account, transaction: transaction)
    end
  end

  def lookup_accounts_by_mobile(conn, %{"mobile_number" => mobile_number}) do
    case AccountTransactionService.lookup_accounts_by_phone(mobile_number) |> IO.inspect do
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

  @spec get_transactions(Plug.Conn.t(), map()) :: Plug.Conn.t()
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

  def nickname(conn, %{"account_number" => account_number, "nickname" => nickname}) do
    case AccountTransactionService.set_nickname(account_number, nickname) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Account not found"})
      account ->
        conn
        |> put_status(:ok)
        |> render("account.json", account: account)
    end
  end

end
