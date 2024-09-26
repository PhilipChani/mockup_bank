defmodule MockupBank.Readers.BankAccounts do
    @moduledoc """
    The ContextTransactionsManagement context.
    """
  
    import Ecto.Query, warn: false
    import MockupBank.DefaultQueries
    alias MockupBank.Repo
    alias MockupBank.Database.UserAccounts, as: Transactions
  
    @query_params Application.compile_env(:mockup_bank, :query_params)
  


  
    @doc """
    Returns the list of Transactionss.
  
    ## Examples
  
        iex> run_list()
        [%Transactions{}, ...]
  
    """

    def run_list(params \\ @query_params) do
        Transactions
        |> preload([:account_users])
        |> sorting_query(params)
        |> search_filter(params)
        |> pagination_query(params)
    end
   
  
    @doc """
    Gets a single Transactions.
  
    Raises `Ecto.NoResultsError` if the Transactions does not exist.
  
    ## Examples
  
        iex> get_Transactions!(123)
        %Transactions{}
  
        iex> get_Transactions!(456)
        ** (Ecto.NoResultsError)
  
    """
    def get_data!(id), do: Repo.get!(Transactions, id)

  
  
    def search_filter(query, %{"search" => search}) when is_nil(search) or search == "", do: query
  
    def search_filter(query, %{"search" => search}) do
      query
      |> where(
        [a],
        fragment("lower(?) LIKE lower(?)", a.account_number, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.currency, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.status, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.account_type, ^"%#{search}%") 
      )
    end
  
    def search_filter(query, _), do: query
  

  end
  