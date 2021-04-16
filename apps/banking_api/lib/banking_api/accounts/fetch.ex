defmodule BankingApi.Accounts.Fetch do
  alias BankingApi.{Account, Repo}

  def fetch_all() do
    Repo.all(Account)
  end

end
