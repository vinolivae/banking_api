defmodule BankingApiWeb.AccountController do
  use BankingApiWeb, :controller
  alias BankingApiWeb.AccountView

  def withdraw(conn, params) do
    with {:ok, account} <- BankingApi.withdraw(params) do
      conn
      |> put_status(:ok)
      |> put_view(AccountView)
      |> render("withdraw.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, to} <- BankingApi.transaction(params) do
      conn
      |> put_status(:ok)
      |> put_view(AccountView)
      |> render("transaction.json", transaction: to)
    end
  end
end
