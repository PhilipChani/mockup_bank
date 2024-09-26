defmodule MockupBankWeb.BankAccountsLive.Index do
    use MockupBankWeb, :live_view
  
    alias MockupBank.Readers.BankAccounts, as: Reader
    @query_params Application.compile_env(:mockup_bank, :query_params)

    @url "/BankAccounts"
  
  
  
    @impl true
    def mount(_params, _session, socket) do
      {:ok, 
        socket
        |> assign(:filter_params, @query_params)
        |> assign(:selected_column, "id")
      }
    end
  
    @impl true
    def handle_params(%{"sort_field" => sort_field} = params, _url, socket) do
      data = Reader.run_list(params)
      pagination = generate_pagination_details(data)
  
      assigns =
        socket.assigns
        |> Map.delete(:streams)
  
      socket =
        socket
        |> Map.update(:assigns, assigns, fn _existing_value -> assigns end)
  
      {:noreply,
        apply_action(socket, socket.assigns.live_action, params)
        |> assign(:selected_column, sort_field)
        |> assign(:filter_params, params)
        |> assign(pagination: pagination)
        |> stream(:transactions, data)}
    end
  
    def handle_params(params, _url, socket) do
      data = Reader.run_list()
      pagination = generate_pagination_details(data)
  
      {:noreply,
        apply_action(socket, socket.assigns.live_action, params)
        |> stream(:transactions, data)
        |> assign(pagination: pagination)}
    end
  
  
    defp apply_action(socket, :index, _params) do
      socket
      |> assign(:page_title, "Bank Accounts")
      |> assign(:transaction, nil)
    end
  
  
    @impl true
    def handle_event("search", %{"search" => search}, socket) do
      {params, endpoint} =
        socket.assigns.filter_params
        |> search_encode_url(search)
  
      {:noreply,
       socket
       |> assign(:filter_params, params)
       |> push_navigate(to: "#{@url}#{endpoint}", replace: true)}
    end
  
    def handle_event("run_query_filter", filter_params, socket) do
      {params, endpoint} =
        socket.assigns.filter_params
        |> dynamic_query_params_encode_url(filter_params)
  
      {:noreply,
       socket
       |> assign(:filter_params, params)
       |> push_navigate(to: "#{@url}#{endpoint}", replace: true)}
    end
  
    def handle_event("page_size", %{"page_size" => page_size}, socket) do
      {params, endpoint} =
        socket.assigns.filter_params
        |> page_size_encode_url(page_size)
  
      {:noreply,
       socket
       |> assign(:filter_params, params)
       |> push_navigate(to: "#{@url}#{endpoint}", replace: true)}
    end
    
  end
  