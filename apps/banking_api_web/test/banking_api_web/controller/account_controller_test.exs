defmodule BankingApiWeb.AccountControllerTest do
  use BankingApiWeb.ConnCase, async: true
  alias BankingApi.Schemas.Account

  describe "withdraw/2" do
    setup %{conn: conn} do
      account_params = %{
        name: "jose",
        surname: "valim",
        email: "#{Enum.random(1..1000)}@email",
        password: "senhasegura123"
      }

      {:ok, conn: conn, account_params: account_params}
    end

    test "succeeds if balance are changed", %{conn: conn, account_params: account_params} do
      %Plug.Conn{assigns: %{user: %{account: %Account{id: id}}}} =
        conn
        |> post(Routes.user_path(conn, :register, account_params))

      assert %{
               "message" => "Balance Changed",
               "account" => %{
                 "id" => ^id,
                 "balance" => _balance
               }
             } =
               conn
               |> patch(
                 Routes.account_path(conn, :withdraw, %{
                   "id" => id,
                   "value" => 500
                 })
               )
               |> json_response(:ok)
    end
  end

  describe "transaction/2" do
    setup %{conn: conn} do
      to_params = %{
        name: "jose",
        surname: "valim",
        email: "#{Enum.random(1..1000)}@email",
        password: "senhasegura123"
      }

      from_params = %{
        name: "valim",
        surname: "jose",
        email: "#{Enum.random(1..1000)}@email",
        password: "senhasegura123"
      }

      {:ok, conn: conn, from_params: from_params, to_params: to_params}
    end

    test "succeeds if transaction carried out", ctx do
      %Plug.Conn{assigns: %{user: %{account: %Account{id: to_id}}}} =
        ctx.conn
        |> post(Routes.user_path(ctx.conn, :register, ctx.to_params))

      %Plug.Conn{assigns: %{user: %{account: %Account{id: from_id}}}} =
        ctx.conn
        |> post(Routes.user_path(ctx.conn, :register, ctx.from_params))

      assert %{
               "message" => "Transaction Carried out",
               "transaction" => %{
                 "id" => _id,
                 "balance" => _balance
               }
             } =
               ctx.conn
               |> patch(
                 Routes.account_path(ctx.conn, :transaction, %{
                   "from" => from_id,
                   "to" => to_id,
                   "value" => 500
                 })
               )
               |> json_response(:ok)
    end
  end
end
