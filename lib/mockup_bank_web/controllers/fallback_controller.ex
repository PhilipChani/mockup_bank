defmodule MockupBankWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use MockupBankWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: MockupBankWeb.ErrorHTML, json: MockupBankWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :insufficient_funds}) do
    conn
    |> assign(:message, "insufficient funds")
    |> put_status(:bad_request)
    |> put_view(html: MockupBankWeb.ErrorHTML, json: MockupBankWeb.ErrorJSON)
    |> render(:"400")
  end

  def call(conn, _) do
    conn
    |> put_status(:internal_server_error )
    |> put_view(html: MockupBankWeb.ErrorHTML, json: MockupBankWeb.ErrorJSON)
    |> render(:"500")
  end
end
