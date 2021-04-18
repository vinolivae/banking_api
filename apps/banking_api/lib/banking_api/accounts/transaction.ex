defmodule BankingApi.Accounts.Transaction do
  @moduledoc false
  alias BankingApi.{Account, Repo}

  def transaction(%{"from" => from, "to" => to, "value" => value}) do
    Repo.transaction(fn ->

        from = get_account(from)
        from
        |> update_balance(value, :sub)
        |> Repo.update()


        to = get_account(to)
        to
        |> update_balance(value, :sum)
        |> Repo.update()
    end)

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

  defp operate_value({:ok, balance}, value, operation) do
    case operation do
      :sum -> Decimal.add(value, balance)
      :sub -> Decimal.sub(value, balance)
      _ -> {:error, "Please, insert an operation"}
    end
  end

  defp update(value, account) do
    params = %{balance: value}
    account
    |> Account.changeset(params)
    |> Repo.update()
  end
end
