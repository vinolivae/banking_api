defmodule BankingApiWeb.UserController do
  use BankingApiWeb, :controller
  # alias BankingApi.User

  def register(conn, params) do
    with {:ok, user} <- BankingApi.create_user(params) do
      # send_json(conn, 201, user)
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show_all(conn, _params) do
    send_json(conn, 200, BankingApi.fetch_all())

  end

  defp send_json(conn, status, body) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(body))
  end
end
