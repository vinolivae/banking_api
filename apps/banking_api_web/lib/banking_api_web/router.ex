defmodule BankingApiWeb.Router do
  use BankingApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingApiWeb do
    pipe_through :api

    post "/users/register", UserController, :register

    patch "/accounts/:id/withdraw", AccountController, :withdraw
    patch "/accounts/transaction", AccountController, :transaction
  end
end
