defmodule BankingApi do
  @moduledoc """
  BankingApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias BankingApi.Users.{Create, Fetch}
  alias BankingApi.Accounts.{FetchAccount, Transaction, Withdraw}

  defdelegate create_user(params), to: Create, as: :create

  defdelegate fetch_all_users, to: Fetch, as: :fetch_all

  defdelegate fetch_all_accounts, to: FetchAccount, as: :fetch_all_accounts
  defdelegate transaction(params), to: Transaction, as: :transaction
  defdelegate withdraw(params), to: Withdraw, as: :withdraw
end
