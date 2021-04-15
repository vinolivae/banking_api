defmodule BankingApi.Users.Fetch do
  alias BankingApi.{User, Repo}


  def fetch_all() do
    case Repo.all(User) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
