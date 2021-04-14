defmodule BankingApiWeb.UserController do
  use BankingApiWeb, :controller

  def register(conn, params) do
    send_resp(conn, 200, Jason.encode!(params))
  end

  def index(conn, params) do
    send_resp(conn, 200, Jason.encode!(params))
  end
end
