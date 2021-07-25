defmodule BankingApi.Accounts.Transaction do
  alias BankingApi.Repo
  alias BankingApi.Schemas.Account

  @doc """
  to test run iex -S mix phx.server
  iex > BankingApi.Accounts.Transaction.transaction(%{"from" => "account_id", "to" => "account_id", "value" => "decimal.value"})
  """
  @spec transaction(map) :: {:ok, Account.t()}
  def transaction(%{"from" => from, "to" => to, "value" => value}) do
    Repo.transaction(fn ->
      with {:ok, account} <- get_account(from),
           {:ok, _from_account} <- update_balance(account, value, :sub),
           {:ok, account} <- get_account(to),
           {:ok, to_account} <- update_balance(account, value, :sum) do
        {:ok, to_account}
      end
    end)
    |> case do
      {:ok, {:ok, %Account{} = account}} -> {:ok, account}
    end
  end

  defp get_account(id) do
    case Repo.get(Account, id) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp update_balance(account, value, operation) do
    account
    |> cast(value, operation)
    |> update(account)
  end

  defp cast(%Account{balance: balance}, value, operation) do
    value
    |> Decimal.cast()
    |> operate_value(balance, operation)
  end

  defp operate_value({:ok, balance}, value, :sum), do: Decimal.add(balance, value)
  defp operate_value({:ok, balance}, value, :sub), do: Decimal.sub(value, balance)
  defp operate_value({:ok, _balance}, _value, _any), do: {:error, "Invalid operation"}

  defp update(value, account) do
    params = %{balance: value}

    account
    |> Account.changeset(params)
    |> Repo.update()
  end
end
