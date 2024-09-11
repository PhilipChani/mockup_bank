defmodule MockupBankWeb.Components.Bi do
    use MockupBankWeb, :live_component
    alias MockupBank.EmbeededSchema.Bi, as: Credit
  
  
    @impl true
    def render(assigns) do
      ~H"""
        <div>
          <.header>
            <%= @title %>
            <:subtitle></:subtitle>
          </.header>

          <.simple_form
            for={@form}
            id="service-form"
            phx-target={@myself}
            phx-submit="save"
          >
            <.input field={@form[:account_number]} type="text" label="Account Number" />

            <:actions>
              <.button phx-disable-with="Processing...">EXECUTE</.button>
            </:actions>
          </.simple_form>
          <div class="mt-6" >
            <span>Response</span>
              <div id="json-viewer" phx-hook="JsonViewerHook" data-json={@json_data} style="width: 100%; height: 100%;"></div>
          </div>
          
        </div>
      """
    end
  
    @impl true
    def update(assigns, socket) do
      struct = %{}
      changeset = Credit.change(struct)
      json_data = "{}"

      {:ok,
        socket
        |> assign(:json_data, json_data)
        |> assign(:struct, struct)
        |> assign(assigns)
        |> assign_form(changeset)}
    end
  
    @impl true
    def handle_event("save", %{"bi" => params}, socket) do
      process_message(socket, params)
    end
  
    defp process_message(socket, data) do
      response = send_data_to_api(data)
      changeset = Credit.change(response)

      {:noreply,
          socket
          |> assign(:json_data, response["response"])
          |> put_flash(:info, "Executed successfully")
          |> assign_form(changeset)}
    end
  
    
    def send_data_to_api(request) do

      IO.inspect(request, label: "====================")
      message = Jason.encode!(request)
      response =
        url(~p"/api/accounts/balance")
        |> HTTPoison.post(message, ["Content-Type": "application/json"]) 
        |> case do
          {:ok, %HTTPoison.Response{body: body}} ->
            body
          {:error, error} ->
            inspect(error)
        end


      request
      |> Map.put("response", response)
    end

    defp assign_form(socket, %Ecto.Changeset{} = changeset) do
      assign(socket, :form, to_form(changeset))
    end
  
  end
  