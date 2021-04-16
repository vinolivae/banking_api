defmodule BankingApi do
  @moduledoc """
  BankingApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias BankingApi.Users.{Create, Fetch}

  defdelegate create_user(params), to: Create, as: :create
  defdelegate fetch_all(), to: Fetch, as: :fetch_all
end
