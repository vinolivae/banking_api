defmodule BankingApi.Accounts.Withdraw do
  alias BankingApi.Repo
  alias BankingApi.Schemas.Account
  alias Ecto.Multi

  @doc """
  to test run iex -S mix phx.server
  iex > BankingApi.Accounts.Withdraw.withdraw(%{"id" => "account_id", "value" => "decimal.value"})
  """
  @spec withdraw(map) :: {:ok, %{account: Account.t(), updated_account: Account.t()}}
  def withdraw(%{"id" => id, "value" => value}) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{account: account} ->
      update_balance(repo, account, value)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{account: account}} ->
        {:ok, account}
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
