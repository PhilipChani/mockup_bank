defmodule MockupBankWeb.Router do
  use MockupBankWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MockupBankWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MockupBankWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", MockupBankWeb do
    pipe_through :api

    post "/accounts", BankController, :create_account
    post "/accounts/credit", BankController, :credit_account
    post "/accounts/debit", BankController, :debit_account
    post "/accounts/transfer", BankController, :transfer_funds
    post "/accounts/lookup", BankController, :lookup_accounts
    post "/accounts/transactions", BankController, :get_transactions
    post "/accounts/balance", BankController, :get_balance
  end

  # Other scopes may use custom stacks.
  # scope "/api", MockupBankWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:mockup_bank, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MockupBankWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
