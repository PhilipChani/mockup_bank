defmodule MockupBankWeb.Utilities.Sorting do
  import MockupBankWeb.Utilities.Extractors

  def filter_handler(new_params) do
    %{
      rrn: new_params["rrn"] || new_params[:rrn],
      mti: new_params["mti"] || new_params[:mti],
      pan: new_params["pan"] || new_params[:pan],
      status_code: new_params["status_code"] || new_params[:status_code],
      status: new_params["status"] || new_params[:status],
      from_date: new_params["from_date"] || new_params[:from_date],
      to_date: new_params["to_date"] || new_params[:to_date],
      sort_field: new_params[:sort_field] || new_params["sort_field"] || "inserted_at",
      sort_order: new_params[:sort_order] || new_params["sort_order"] || "desc",
      search: new_params[:search] || new_params["search"],
      page_size: new_params[:page_size] || new_params["page_size"] || "20",
      page: new_params[:page] || new_params["page"] || 1
    }
    |> txn_querystring()
  end

  def table_link_encode_url(params, field) do
    "?#{querystring(params, options(params, field))}"
  end

  def table_link_encode_url(params) do
    opts = options(params)
    url = "?#{querystring(params, opts)}"
    direction = params[:sort_order] || params["sort_order"]

    new_params =
      params
      |> Map.put("sort_order", reverse(direction))

    {new_params, url}
  end

  def search_encode_url(params, search) do
    opts = search_options(params, search)
    url = "?#{querystring_search(params, opts)}"

    new_params =
      params
      |> Map.put("search", search)

    {new_params, url}
  end

  def search_encode_url(params, from_datetime, to_datetime) do
    opts = search_options(params, from_datetime, to_datetime)
    url = "?#{querystring_search(params, opts)}"

    new_params =
      params
      |> Map.put("from_datetime", from_datetime)
      |> Map.put("to_datetime", to_datetime)

    {new_params, url}
  end

  def page_size_encode_url(params, page_size) do
    opts = page_size_options(params, page_size)
    url = "?#{querystring_page_size(params, opts)}"

    new_params =
      params
      |> Map.put("page_size", page_size)

    {new_params, url}
  end

  def dynamic_query_params_encode_url(params, filter_params) do
    url = "?#{querystring_page_size(params, filter_params)}"

    new_params =
      params
      |> Map.merge(filter_params)

    {new_params, url}
  end

  defp page_size_options(_params, page_size) do
    %{
      "page_size" => page_size
    }
  end

  defp search_options(params, search) do
    #        %{
    #            sort_field: get_sort_field(params),
    #            page: get_page(params),
    #            page_size: get_page_size(params),
    #            search: search,
    #            sort_order: get_sort_order(params)
    #        }
    params
    |> Map.put("search", search)
  end

  defp search_options(params, from_datetime, to_datetime) do
    #        %{
    #            sort_field: get_sort_field(params),
    #            page: get_page(params),
    #            page_size: get_page_size(params),
    #            search: search,
    #            sort_order: get_sort_order(params)
    #        }
    params
    |> Map.put("from_datetime", from_datetime)
    |> Map.put("to_datetime", to_datetime)
  end

  defp options(params, field) do
    %{
      sort_field: field,
      page: get_page(params),
      page_size: get_page_size(params),
      search: get_search(params),
      sort_order: reverse(get_sort_order(params))
    }
  end

  defp options(params) do
    %{
      sort_field: get_sort_field(params),
      page: get_page(params),
      page_size: get_page_size(params),
      search: get_search(params),
      sort_order: get_sort_order(params)
    }
  end

  defp querystring(params, opts) do
    params = params |> Plug.Conn.Query.encode() |> URI.decode_query()

    opts = %{
      # For the sorting
      "page" => get_page(opts),
      "sort_field" => get_sort_field(opts),
      "sort_order" => get_sort_order(opts)
    }

    params
    |> Map.merge(opts)
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
    |> URI.encode_query()
  end

  defp querystring_page_size(params, opts) do
    params = params |> Plug.Conn.Query.encode() |> URI.decode_query()

    params
    |> Map.merge(opts)
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
    |> URI.encode_query()
  end

  defp querystring_search(params, opts) do
    params = params |> Plug.Conn.Query.encode() |> URI.decode_query()

    params
    |> Map.merge(opts)
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
    |> URI.encode_query()
  end

  defp reverse("desc"), do: "asc"
  defp reverse(_), do: "desc"

  def get_order(order) do
    case order do
      "desc" -> :desc
      "asc" -> :asc
    end
  end

  defp txn_querystring(params, _opts \\ %{}) do
    params = params |> Plug.Conn.Query.encode() |> URI.decode_query()

    params
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
    |> URI.encode_query()
  end
end
