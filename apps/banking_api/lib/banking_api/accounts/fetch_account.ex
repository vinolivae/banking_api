defmodule BankingApi.Accounts.FetchAccount do
  alias BankingApi.{Account, Repo}

  @spec fetch_all_accounts :: {:error, :not_found} | {:ok, list}
  def fetch_all_accounts do
    case Repo.all(Account) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end
end
