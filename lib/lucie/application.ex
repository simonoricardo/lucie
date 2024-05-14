defmodule Lucie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LucieWeb.Telemetry,
      Lucie.Repo,
      {DNSCluster, query: Application.get_env(:lucie, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Lucie.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Lucie.Finch},
      # Start a worker by calling: Lucie.Worker.start_link(arg)
      # {Lucie.Worker, arg},
      # Start to serve requests, typically the last entry
      LucieWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lucie.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LucieWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
