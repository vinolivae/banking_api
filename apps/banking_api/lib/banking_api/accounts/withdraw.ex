defmodule BankingApi.Accounts.Withdraw do
  alias Ecto.Multi
  alias BankingApi.{Account, Repo}

  @spec withdraw(map) :: {:ok, %{account: Account.t(), update_balance: Account.t()}}
  def withdraw(%{"id" => id, "value" => value}) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{account: account} ->
      update_balance(repo, account, value)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{account: account, update_balance: update_balance}} ->
        {:ok, %{account: account, update_balance: update_balance}}
    end
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> cast(value)
    |> update(repo, account)
  end

  defp cast(%Account{balance: balance}, value) do
    value
    |> Decimal.cast()
    |> sub_value(balance)
  end

  defp sub_value({:ok, balance}, value) do
    Decimal.sub(value, balance)
  end

  defp update(value, repo, account) do
    params = %{balance: value}

    account
    |> Account.changeset(params)
    |> repo.update()
  end
end
