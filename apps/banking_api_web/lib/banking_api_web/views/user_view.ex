defmodule BankingApiWeb.UserView do
  # alias BankingApi.{User, Account}
  use BankingApiWeb, :view

  def render("create.json", %{user: user}) do
    user
  end

  # def render("create.json", %{
  #       user: %User{
  #         account: %Account{id: account_id, balance: balance},
  #         id: id,
  #         name: name,
  #         surname: surname,
  #         email: email,
  #         senha: senha
  #       }
  #     }) do
  #   %{
  #     message: "User",
  #     user: %{
  #       account: %{
  #         id: account_id,
  #         balance: balance
  #       },
  #       id: id,
  #       name: name,
  #       surname: surname,
  #       email: email,
  #       senha: senha
  #     }
  #   }
  # end
end
