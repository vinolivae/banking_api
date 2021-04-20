defmodule BankingApi.Users.Fetch do
  alias BankingApi.{Repo, User}

  @spec fetch_all :: {:error, :not_found} | {:ok, list}
  def fetch_all do
    case Repo.all(User) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
