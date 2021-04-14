defmodule BankingApi.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias BankingApi.Account

  @required_params [:name, :surname, :email, :senha]
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :name, :string
    field :surname, :string
    field :email, :string
    field :senha, :string

    has_one :account, Account
    timestamps()
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3)
  end
end
