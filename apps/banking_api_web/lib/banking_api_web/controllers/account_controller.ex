defmodule BankingApiWeb.AccountController do
  use BankingApiWeb, :controller

  alias BankingApiWeb.AccountView
  alias BankingApi.Accounts.Inputs.{Transaction, Withdraw}
  alias BankingApi.Validation.ChangesetValidation

  def withdraw(conn, params) do
    with {:ok, input} <- ChangesetValidation.cast_and_apply(Withdraw, params),
         input <- Map.from_struct(input),
         {:ok, account} <- BankingApi.withdraw(input) do
      conn
      |> put_status(:ok)
      |> put_view(AccountView)
      |> render("withdraw.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, input} <- ChangesetValidation.cast_and_apply(Transaction, params),
         input <- Map.from_struct(input),
         {:ok, to} <- BankingApi.transaction(input) do
      conn
      |> put_status(:ok)
      |> put_view(AccountView)
      |> render("transaction.json", transaction: to)
    end
  end
end
