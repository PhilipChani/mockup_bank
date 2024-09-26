defmodule MockupBank.Readers.AccountHolders do
    @moduledoc """
    The ContextTransactionsManagement context.
    """
  
    import Ecto.Query, warn: false
    import MockupBank.DefaultQueries
    alias MockupBank.Repo
    alias MockupBank.Database.AccountUsers, as: Transactions
  
    @query_params Application.compile_env(:mockup_bank, :query_params)
  


  
    @doc """
    Returns the list of Transactionss.
  
    ## Examples
  
        iex> run_list()
        [%Transactions{}, ...]
  
    """

    def run_list(params \\ @query_params) do
        Transactions
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
        fragment("lower(?) LIKE lower(?)", a.email, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.name, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.phone, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.address, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.city, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.state, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.zip, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.country, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.region, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.postal_code, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.identifier_type, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.identifier_number, ^"%#{search}%") or
          fragment("lower(?) LIKE lower(?)", a.currency, ^"%#{search}%") 
      )
    end
  
    def search_filter(query, _), do: query
  

  end
  