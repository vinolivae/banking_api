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

  def render("transaction.json", %{transaction: %Account{id: id, balance: balance}}) do
    %{
      message: "Transaction Carried out",
      transaction: %{
        id: id,
        balance: balance
      }
    }
  end
end
