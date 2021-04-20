defmodule BankingApiWeb.UserView do
  alias BankingApi.{Account, User}
  use BankingApiWeb, :view

  def render("create.json", %{
        user: %{
          account: %Account{id: account_id, balance: balance},
          user: %User{
            id: id,
            name: name,
            surname: surname,
            email: email,
            password: password
          }
        }
      }) do
    %{
      message: "User",
      user: %{
        account: %{
          id: account_id,
          balance: balance
        },
        id: id,
        name: name,
        surname: surname,
        email: email,
        password: password
      }
    }
  end
end
