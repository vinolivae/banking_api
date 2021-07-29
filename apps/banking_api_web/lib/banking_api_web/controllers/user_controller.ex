defmodule BankingApiWeb.UserController do
  use BankingApiWeb, :controller

  alias BankingApi.Users.Inputs.User
  alias BankingApi.Validation.ChangesetValidation
  alias BankingApiWeb.UserView

  def register(conn, params) do
    with {:ok, input} <- ChangesetValidation.cast_and_apply(User, params),
         {:ok, user} <- BankingApi.create_user(input) do
      conn
      |> put_status(:created)
      |> put_view(UserView)
      |> render("create.json", user: user)
    end
  end
end
