defmodule MockupBankWeb.BankJSON do


  def account(%{account: account}) do
    %{
      account_number: account.account_number,
      balance: Decimal.to_string(account.balance, :normal),
      currency: account.currency,
      account_type: account.account_type,
      status: account.status
    }
  end

  def account_with_transaction(%{account: account, transaction: transaction}) do
    %{
      account: account(%{account: account}),
      transaction: %{
        id: transaction.id,
        type: transaction.type,
        amount: transaction.amount,
        description: transaction.description,
        status: transaction.status,
        inserted_at: transaction.inserted_at
      }
    }
  end

  def transfer_with_transaction(%{from: from, to: to, transaction: transaction}) do
    %{
      from_account: account(%{account: from}),
      to_account: account(%{account: to}),
      transaction: %{
        id: transaction.id,
        type: transaction.type,
        amount: transaction.amount,
        description: transaction.description,
        status: transaction.status,
        inserted_at: transaction.inserted_at
      }
    }
  end

  def account_user(%{account_user: account_user}) do
    %{
      id: account_user.id,
      email: account_user.email,
      name: account_user.name,
      accounts: Enum.map(account_user.user_accounts, &account(%{account: &1}))
    }
  end

  def transactions(%{transactions: transactions}) do
    %{
      transactions: Enum.map(transactions, fn transaction ->
        %{
          id: transaction.id,
          type: transaction.type,
          amount: transaction.amount,
          description: transaction.description,
          status: transaction.status,
          from_account_id: transaction.from_account_id,
          to_account_id: transaction.to_account_id,
          inserted_at: transaction.inserted_at
        }
      end)
    }
  end
end
