defmodule BankingApi.Users.Create do
  alias BankingApi.{Repo, User, Account}
  alias Ecto.Multi

  def create(params) do
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
      insert_account(repo, user)
    end)
    |> Multi.run(:preload, fn repo, %{create_user: user} ->
      preload_data(repo, user)
    end)
    |> Repo.transaction()
  end

  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp account_changeset(user_id) do
    Account.changeset(%{user_id: user_id, balance: "1000.0"})
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end
end
