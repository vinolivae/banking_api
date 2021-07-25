defmodule BankingApi.Users.Fetch do
  alias BankingApi.Repo
  alias BankingApi.Schemas.User

  @doc """
  to test run iex -S mix phx.server
  iex > BankingApi.Accounts.FetchAccount.fetch_all_accounts()
  """
  @spec fetch_all :: {:error, :not_found} | {:ok, list}
  def fetch_all do
    case Repo.all(User) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
