defmodule BankingApi.Users.Inputs.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:name, :surname, :email, :password, :password]

  @primary_key false
  embedded_schema do
    field :name, :string
    field :surname, :string
    field :email, :string
    field :password, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
  end
end
