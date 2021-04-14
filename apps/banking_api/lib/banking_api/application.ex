defmodule BankingApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BankingApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BankingApi.PubSub}
      # Start a worker by calling: BankingApi.Worker.start_link(arg)
      # {BankingApi.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: BankingApi.Supervisor)
  end
end
