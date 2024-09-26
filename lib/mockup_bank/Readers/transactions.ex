defmodule MockupBank.Readers.Transactions do
    @moduledoc """
    The ContextTransactionsManagement context.
    """
  
    import Ecto.Query, warn: false
    import MockupBank.DefaultQueries
    alias MockupBank.Repo
    alias MockupBank.Database.Transaction, as: Transactions
  
    @query_params Application.compile_env(:mockup_bank, :query_params)
  


  
    @doc """
    Returns the list of Transactionss.
  
    ## Examples
  
        iex> run_list()
        [%Transactions{}, ...]
  
    """

    def run_list(params \\ @query_params) do
        Transactions
      # |> status_query()
      #    |> preload([:maker, :checker])
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
        fragment("lower(?) LIKE lower(?)", a.type, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.description, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.status, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.reference, ^"%#{search}%") 
      )
    end
  
    def search_filter(query, _), do: query
  

  end
  