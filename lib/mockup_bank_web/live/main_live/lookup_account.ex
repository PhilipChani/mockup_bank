defmodule MockupBankWeb.MainLive.LookupAccount do
    use MockupBankWeb, :live_view
  
  
    @impl true
    def mount(_params, _session, socket) do
      {:ok,
       socket
       |> assign(:json_data, "{}")
    }
    end
  
    @impl true  
    def handle_params(params, _url, socket) do
  
      {:noreply,
       apply_action(socket, socket.assigns.live_action, params)}
    end
  
  
    defp apply_action(socket, :index, _params) do
      socket
      |> assign(:page_title, "Account List")
    end
  
  
  
    @impl true
    def handle_event("save", params, socket) do
      process_message(socket, params)
    end
  
    defp process_message(socket, data) do
      response =
      data
      |> send_data_to_api()
  
      {:noreply,
          socket
          |> assign(:json_data, response["response"])
          |> assign(:response, response["response"])
          |> put_flash(:info, "Executed successfully")
      }
    end
  
        
    def send_data_to_api(request) do
  
        IO.inspect(request, label: "====================")
        message = Jason.encode!(request)
        response =
          try do
            url(~p"/api/accounts/lookup")
            |> String.replace("https://[", "")
              |> String.replace("http://[", "")
              |> String.replace("]", "")
              |> String.replace("[", "")
              |> IO.inspect(label: "FULL PATH")
              |> HTTPoison.post(message, ["Content-Type": "application/json"]) 
              |> case do
              {:ok, %HTTPoison.Response{body: body}} ->
                  body
              {:error, error} ->
                  Jason.encode!(%{response: inspect(error)})
              end        rescue
                  error ->
                      Jason.encode!(%{response: inspect(error)})
              end
    
        request
        |> Map.put("response", response)
    end
  
  
  
  end
  