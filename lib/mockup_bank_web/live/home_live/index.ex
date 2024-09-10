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
        %{name: "Credit Account", url: "/mesages/credit"},
        %{name: "Debit Account", url: "/mesages/debit"},
        %{name: "Transfer", url: ""},
        %{name: "Account Balance", url: "/mesages/bi"},
        %{name: "Post Accounts", url: ""},
        %{name: "Lookup Accounts", url: ""},

      ]
    end
 
  end
  