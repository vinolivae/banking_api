defmodule BankingApi.Users.Create do
  alias BankingApi.Repo
  alias BankingApi.Schemas.{Account, User}
  alias Ecto.Multi

  @doc """
  to test run iex -S mix phx.server
  iex > BankingApi.Users.Create.create(%{name: "name", surname: "surname", email: "email@email", password: "password"})
  """
  @spec create(params :: map) :: {:ok, %{account: Account.t(), user: User.t()}}
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
    |> case do
      {:ok, %{create_account: account, create_user: user}} ->
        {:ok, %{account: account, user: user}}
    end
  end

  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp account_changeset(user_id), do: Account.changeset(%{user_id: user_id, balance: "1000.0"})

  defp preload_data(repo, user), do: {:ok, repo.preload(user, :account)}
end
