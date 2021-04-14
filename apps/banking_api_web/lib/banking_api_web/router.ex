defmodule BankingApiWeb.Router do
  use BankingApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingApiWeb do
    pipe_through :api


    get "/users", UserController, :index
    post "/users/register", UserController, :register

    post "/accounts/:id/withdraw", AccountController, :withdraw
    post "/accounts/transaction", AccountController, :transaction
  end
end
