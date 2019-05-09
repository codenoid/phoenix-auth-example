defmodule Single.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      SingleWeb.Endpoint
      # Starts a worker by calling: Single.Worker.start_link(arg)
      # {Single.Worker, arg},
    ]

    # create table for web session
    :ets.new(:web_session, [:set, :public, :named_table])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Single.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SingleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
