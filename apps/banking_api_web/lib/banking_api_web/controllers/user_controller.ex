defmodule BankingApiWeb.UserController do
  use BankingApiWeb, :controller
  alias BankingApi.User

  def register(conn, params) do
    with {:ok, %User{} = user} <- BankingApi.create_user(params) do
      conn
      |> put_status(201)
      |> render("create.json", user: user)
    end
  end

  def index(conn, params) do
    send_resp(conn, 200, Jason.encode!(params))
  end

  # defp send_json(conn, status, body) do
  #   conn
  #   |> put_resp_header("content-type", "application/json")
  #   |> send_resp(status, Jason.encode!(body))
  # end
end
