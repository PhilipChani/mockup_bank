defmodule MockupBankWeb.BankJSON do

  def account(%{account: account}) do
    account
  end

  def by_account_number(%{account: account}) do
    %{
      account_number: account.account_number,
      balance: Decimal.to_string(account.balance, :normal),
      currency: account.currency,
      account_type: account.account_type,
      status: account.status,
      profile: account.account_users
    }
  end

  @spec account_with_transaction(%{
          :account =>
            atom()
            | %{
                :account_number => any(),
                :account_type => any(),
                :balance => Decimal.t(),
                :currency => any(),
                :status => any(),
                optional(any()) => any()
              },
          :transaction =>
            atom()
            | %{
                :amount => Decimal.t(),
                :description => any(),
                :id => any(),
                :inserted_at => any(),
                :status => any(),
                :type => any(),
                optional(any()) => any()
              },
          optional(any()) => any()
        }) :: %{
          account: %{
            account_number: any(),
            account_type: any(),
            balance: binary(),
            currency: any(),
            status: any()
          },
          transaction: %{
            amount: binary(),
            description: any(),
            id: any(),
            inserted_at: any(),
            status: any(),
            type: any()
          }
        }
  def account_with_transaction(%{account: account, transaction: transaction}) do
    %{
      account: account(%{account: account}),
      transaction: %{
        id: transaction.id,
        book_date: transaction.inserted_at,
        reference: transaction.reference,
        description: transaction.description,
        value_date: transaction.value_date,
        debit: Decimal.to_string(transaction.debit_amount, :normal),
        credit: Decimal.to_string(transaction.credit_amount, :normal),
        opening: Decimal.to_string(transaction.opening_balance, :normal),
        closing: Decimal.to_string(transaction.closing_balance, :normal),
        type: transaction.type,
        amount: Decimal.to_string(transaction.amount, :normal),
        status: transaction.status,
        inserted_at: transaction.inserted_at
      }
    }
  end

  def transfer_with_transaction(%{from: from, to: to, transaction: transaction}) do
    %{
      from_account: account(%{account: from}),
      to_account: account(%{account: to}),
      transaction: transaction
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
          book_date: transaction.inserted_at,
          reference: transaction.reference,
          description: transaction.description,
          value_date: transaction.value_date,
          debit: Decimal.to_string(transaction.debit_amount, :normal),
          credit: Decimal.to_string(transaction.credit_amount, :normal),
          opening: Decimal.to_string(transaction.opening_balance, :normal),
          closing: Decimal.to_string(transaction.closing_balance, :normal),
          type: transaction.type,
          amount: Decimal.to_string(transaction.amount, :normal),
          status: transaction.status,
          inserted_at: transaction.inserted_at
        }
      end)
    }
  end

  def balance(%{account: account}) do
    %{
      account_number: account.account_number,
      balance: Decimal.to_string(account.balance, :normal),
      currency: account.currency,
      last_transaction_date: account.last_transaction_date
    }
  end
end
