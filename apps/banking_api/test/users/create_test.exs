defmodule BankingApi.Users.CreateTest do
  use ExUnit.Case, async: true
  alias BankingApi.Schemas.{Account, User}
  alias BankingApi.Users.Create
  alias Ecto.Adapters.SQL.Sandbox

  describe "create/1" do
    setup do
      :ok = Sandbox.checkout(BankingApi.Repo)
    end

    test "succeeds if user and account are created successfully" do
      params = %{
        name: "jose",
        surname: "valim",
        email: "zevalim@email",
        password: "senhasegura123"
      }

      assert {:ok, %{account: %Account{}, user: %User{}}} = Create.create(params)
    end
  end
end
