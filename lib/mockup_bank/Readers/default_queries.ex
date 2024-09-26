defmodule MockupBank.DefaultQueries do
    @moduledoc false
    import Ecto.Query, warn: false
    alias MockupBank.Repo 
  
    @allowed_status ~w(ACTIVE INACTIVE inactive active, pending PENDING)s
  
    def status_query(query) do
      query
      |> where([a], a.status in @allowed_status)
    end
  
    def group_id_query(query, %{"group_id" => group_id}) when is_nil(group_id) or group_id == "",
      do: query
  
    def group_id_query(query, %{"group_id" => group_id}) do
      query
      |> where([a], a.group_id == type(^group_id, :integer))
    end
  
    def sorting_query(query, %{"sort_field" => sort_field, "sort_order" => sort_direction}) do
      field = String.to_existing_atom(sort_field)
  
      if sort_direction in ["asc", :asc, "ASC", :ASC] do
        query
        |> order_by([a], asc: ^field)
      else
        query
        |> order_by([a], desc: ^field)
      end
    end
  
    def sorting_query(query, %{sort_field: sort_field, sort_direction: sort_direction}) do
      field = String.to_existing_atom(sort_field)
  
      if sort_direction in ["asc", :asc, "ASC", :ASC] do
        query
        |> order_by([a], asc: ^field)
      else
        query
        |> order_by([a], desc: ^field)
      end
    end
  
    def sorting_query(query, _params) do
      query
      |> order_by([a], desc: :inserted_at)
    end
  
    def pagination_query(query, %{page: page, page_size: page_size}) do
      query
      |> Repo.paginate(page: page, page_size: page_size)
    end
  
    def pagination_query(query, %{"page" => page, "page_size" => page_size}) do
      query
      |> Repo.paginate(page: page, page_size: page_size)
    end
  
    def pagination_query(query, _), do: Repo.paginate(query)
  end
  