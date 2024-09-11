defmodule MockupBankWeb.HomeLive.Index do
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
      |> assign(:page_title, "Dashboard")
    end

    def services() do
      [
        %{name: "DEPOSIT", url: "/mesages/credit"},
        %{name: "WITHDRAW", url: "/mesages/debit"},
        %{name: "REPORT", url: "/mesages/at"},
        %{name: "BALANCE", url: "/mesages/bi"},
        %{name: "REGISTER", url: "/mesages/post_txn"},
        %{name: "ACCOUNTS", url: "/mesages/la"},

      ]
    end
 
  end
  