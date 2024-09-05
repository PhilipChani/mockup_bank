defmodule MockupBank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MockupBankWeb.Telemetry,
      MockupBank.Repo,
      {DNSCluster, query: Application.get_env(:mockup_bank, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MockupBank.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MockupBank.Finch},
      # Start a worker by calling: MockupBank.Worker.start_link(arg)
      # {MockupBank.Worker, arg},
      # Start to serve requests, typically the last entry
      MockupBankWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MockupBank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MockupBankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
