defmodule BankingApi.Accounts.WithdrawTest do
  use ExUnit.Case, async: true
  alias BankingApi.Accounts.Withdraw
  alias BankingApi.Schemas.{Account, User}
  alias BankingApi.Users.Create
  alias Ecto.Adapters.SQL.Sandbox

  describe "withdraw/1" do
    setup do
      :ok = Sandbox.checkout(BankingApi.Repo)
    end

    test "success if the withdraw is successful" do
      params = %{
        name: "jose",
        surname: "valim",
        email: "zevalim@email",
        password: "senhasegura123"
      }

      assert {:ok, %{account: %Account{id: account_id}, user: %User{}}} = Create.create(params)

      assert {:ok, _account} = Withdraw.withdraw(%{id: account_id, value: "1.0"})
    end
  end
end
