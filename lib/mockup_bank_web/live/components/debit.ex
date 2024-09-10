defmodule MockupBankWeb.Components.Debit do
    use MockupBankWeb, :live_component
    alias MockupBank.EmbeededSchema.Debit, as: Credit
  
  
    @impl true
    def render(assigns) do
      ~H"""
        <div>
          <.header>
            <%= @title %>
            <:subtitle>Use this form to manage service records in your database.</:subtitle>
          </.header>

          <.simple_form
            for={@form}
            id="service-form"
            phx-target={@myself}
            phx-submit="save"
          >
            <.input field={@form[:account_number]} type="text" label="Account Number" />
            <.input field={@form[:amount]} type="text" label="Amount" />
            <.input field={@form[:response]} type="textarea" readonly="readonly" label="Response" />

            <:actions>
              <.button phx-disable-with="Saving...">EXECUTE</.button>
            </:actions>
          </.simple_form>
        </div>
      """
    end
  
    @impl true
    def update(assigns, socket) do
      struct = %{}
      changeset = Credit.change(struct)
      {:ok,
        socket
        |> assign(:struct, struct)
        |> assign(assigns)
        |> assign_form(changeset)}
    end
  
    @impl true
    def handle_event("save", %{"debit" => params}, socket) do
      process_message(socket, params)
    end
  
    defp process_message(socket, data) do
      response = send_data_to_api(data)
      changeset = Credit.change(response)

      {:noreply,
          socket
          |> put_flash(:info, "Executed successfully")
          |> assign_form(changeset)}
    end
  
    
    def send_data_to_api(request) do

      IO.inspect(request, label: "====================")
      message = Jason.encode!(request)
      response =
        url(~p"/api/accounts/debit")
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
  