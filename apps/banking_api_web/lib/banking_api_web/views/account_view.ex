defmodule BankingApiWeb.AccountView do
  use BankingApiWeb, :view
  alias BankingApi.Account

  def render("withdraw.json", %{account: %Account{id: id, balance: balance}}) do
    %{
      message: "Balance Changed",
      account: %{
        id: id,
        balance: balance
      }
    }
  end

  def render("transaction.json", %{account: %Account{id: id, balance: balance}}) do
    %{
      message: "Transaction Carried out",
      account: %{
        id: id,
        balance: balance
      }
    }
  end
end
