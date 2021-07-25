defmodule BankingApi.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias BankingApi.Account

  @required_params [:name, :surname, :email, :password]
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :name, :string
    field :surname, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_one :account, Account
    timestamps()
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
