defmodule MockupBankWeb.TxnLive.Index do
    use MockupBankWeb, :live_view
  
  
    @impl true
    def mount(_params, _session, socket) do
      {:ok,
       socket}
    end
  
    @impl true  
    def handle_params(params, _url, socket) do
  
      {:noreply,
       apply_action(socket, socket.assigns.live_action, params)}
    end
  

    defp apply_action(socket, :index, _params) do
      socket
      |> assign(:page_title, "Messages")
    end

    
    defp apply_action(socket, :credit, _params) do
      socket
      |> assign(:page_title, "DEPOSIT")
    end

    defp apply_action(socket, :at, _params) do
      socket
      |> assign(:page_title, "TRANSACTION REPORT")
    end

    defp apply_action(socket, :post_txn, _params) do
      socket
      |> assign(:page_title, "NEW ACCOUNT")
    end

    defp apply_action(socket, :la, _params) do
      socket
      |> assign(:page_title, "ACCOUNTS")
    end    

    defp apply_action(socket, :debit, _params) do
      socket
      |> assign(:page_title, "WITHDRAW")
    end

    defp apply_action(socket, :bi, _params) do
      socket
      |> assign(:page_title, "BALANCE")
    end

    def services() do
      [
        %{name: "Credit Account", url: ""},
        %{name: "Debit Account", url: ""},
        %{name: "Transfer", url: ""},
        %{name: "Account Balance", url: ""},
        %{name: "Post Accounts", url: ""},
        %{name: "Lookup Accounts", url: ""},

      ]
    end
 
  end
  