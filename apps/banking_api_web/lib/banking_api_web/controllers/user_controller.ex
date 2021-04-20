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
end
