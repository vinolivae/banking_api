defmodule BankingApi.Accounts.TransactionTest do
  use ExUnit.Case, async: true
  alias BankingApi.Accounts.Transaction
  alias BankingApi.Schemas.{Account, User}
  alias BankingApi.Users.Create
  alias Ecto.Adapters.SQL.Sandbox

  describe "transaction/1" do
    setup do
      :ok = Sandbox.checkout(BankingApi.Repo)
    end

    test "success if the transaction is successful" do
      create_user_1 = %{
        name: "jose",
        surname: "valim",
        email: "zevalim@email",
        password: "senhasegura123"
      }

      create_user_2 = %{
        name: "joao",
        surname: "valinho",
        email: "zevalim@email.com",
        password: "senhasegura123"
      }

      assert {:ok, %{account: %Account{id: account_id_1}, user: %User{}}} =
               Create.create(create_user_1)

      assert {:ok, %{account: %Account{id: account_id_2}, user: %User{}}} =
               Create.create(create_user_2)

      assert {:ok, _account} =
               Transaction.transaction(%{from: account_id_1, to: account_id_2, value: "1.0"})
    end
  end
end
