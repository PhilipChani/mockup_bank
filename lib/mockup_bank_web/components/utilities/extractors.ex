defmodule MockupBankWeb.Utilities.Extractors do
  def get_sort_field(%{"sort_field" => value}), do: value
  def get_sort_field(%{sort_field: value}), do: value
  def get_sort_field(_), do: nil

  def get_sort_order(%{"sort_order" => value}), do: value
  def get_sort_order(%{sort_order: value}), do: value
  def get_sort_order(_), do: "desc"

  def get_page(%{"page" => value}), do: value
  def get_page(%{page: value}), do: value
  def get_page(_), do: 1

  def get_search(%{"search" => value}), do: value
  def get_search(%{search: value}), do: value
  def get_search(_), do: ""

  def get_page_size(%{"page_size" => value}), do: value
  def get_page_size(%{page_size: value}), do: value
  def get_page_size(_), do: 10

  def get_query_field(%{"query_field" => value}), do: value
  def get_query_field(%{query_field: value}), do: value
  def get_query_field(_any), do: ""

  def get_query_search(%{"query_search" => value}), do: value
  def get_query_search(%{query_search: value}), do: value
  def get_query_search(_any), do: ""

  def get_operator(%{"operator" => value}), do: value
  def get_operator(%{operator: value}), do: value
  def get_operator(_any), do: ""
end
