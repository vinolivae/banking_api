defmodule BankingApi.Accounts.Withdraw do
  alias Ecto.Multi
  alias BankingApi.{Repo, Account}


  def withdraw(%{"id" => id, "value" => value}) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{account: account} ->
      update_balance(repo, account, value)
    end)
    |> Repo.transaction()
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> sub_value(value)
    |> update(repo, account)
  end

  defp sub_value(%Account{balance: balance}, value) do
    value
    |> Decimal.cast()
    |> cast(balance)
  end

  defp cast({:ok, balance}, value) do
    Decimal.sub(value, balance)
  end

  defp update(value, repo, account) do
    params = %{balance: value}
    account
    |> Account.changeset(params)
    |> repo.update()
  end
end
