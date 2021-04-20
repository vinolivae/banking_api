defmodule BankingApiWeb.UserController do
  use BankingApiWeb, :controller

  alias BankingApiWeb.UserView

  def register(conn, params) do
    with {:ok, user} <- BankingApi.create_user(params) do
      conn
      |> put_status(:created)
      |> put_view(UserView)
      |> render("create.json", user: user)
    end
  end

  def show_all(conn, _params) do
    {:ok, users} = BankingApi.fetch_all_users()

    maped_users =
      Enum.map(users, &Map.from_struct/1) |> Enum.map(&Map.drop(&1, [:account, :__meta__]))

    send_json(conn, 200, maped_users)
  end

  defp send_json(conn, status, body) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(body))
  end
end
