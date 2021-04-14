defmodule BankingApiWeb.AccountController do
  use BankingApiWeb, :controller

  def withdraw(conn, _params) do
    conn
    |> IO.puts()
  end

  def transaction(conn, _params) do
    conn
    |> IO.puts()
  end
end
