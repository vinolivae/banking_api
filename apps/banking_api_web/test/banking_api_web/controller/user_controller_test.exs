defmodule BankingApiWeb.UserControllerTest do
  use BankingApiWeb.ConnCase, async: true

  describe "register/2" do
    setup %{conn: conn} do
      params = %{
        name: "jose",
        surname: "valim",
        email: "zevalim@email",
        password: "senhasegura123"
      }

      {:ok, conn: conn, params: params}
    end

    test "succeeds if user are register", %{conn: conn, params: params} do
      assert %{
               "message" => "User",
               "user" => %{
                 "account" => %{
                   "id" => _account_id,
                   "balance" => "1000.0"
                 },
                 "id" => _id,
                 "name" => "jose",
                 "surname" => "valim",
                 "email" => "zevalim@email"
               }
             } =
               conn
               |> post(Routes.user_path(conn, :register, params))
               |> json_response(:created)
    end
  end
end
