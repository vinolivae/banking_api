defmodule BankingApiWeb.UserController do
  use BankingApiWeb, :controller

  require Logger

  alias BankingApi.Users.Inputs.User, as: UserInput
  alias BankingApi.Validation.ChangesetValidation
  alias BankingApiWeb.UserView

  #
  def register(conn, params) do
    with {:ok, input} <- ChangesetValidation.cast_and_apply(UserInput, params),
         input <- Map.from_struct(input),
         {:ok, user} <- BankingApi.create_user(input) do
      conn
      |> put_status(:created)
      |> put_view(UserView)
      |> render("create.json", user: user)
    end
  end
end
