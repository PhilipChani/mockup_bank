defmodule MockupBankWeb.Utilities.Pagination do

  import MockupBankWeb.Utilities.Extractors
  # import Phoenix.LiveView.Helpers

  def get_priv_pagination_link(entries, params) do
    opts = generate_options(params, reduce_page(entries.page_number))
    "?" <> querystring(params, opts)
  end

  def get_next_pagination_link(entries, params) do
    opts = generate_options(params, add_page(entries.page_number))

    "?" <> querystring(params, opts)
  end

  def get_number_pagination_link(page, params) do
    opts = generate_options(params, page)

    "?" <> querystring(params, opts)
  end

  defp querystring(request, opts) do
    params =
      request
      |> Map.delete("page")
      |> Map.delete(:page)
      |> Plug.Conn.Query.encode()
      |> URI.decode_query()

    opts = %{
      # For the pagination
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

  def generate_options(params, page) do
    %{
      sort_field: get_sort_field(params),
      sort_order: get_sort_order(params),
      search: get_search(params),
      page_size: get_page_size(params),
      page: page
    }
  end

  def reduce_page(page_number) do
    page_number - 1
  end

  def add_page(page_number) do
    page_number + 1
  end
end
