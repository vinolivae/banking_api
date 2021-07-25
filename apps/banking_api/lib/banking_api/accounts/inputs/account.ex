defmodule BankingApi.Inputs.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:balance]

  @primary_key false
  embedded_schema do
    field :balance, :decimal
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end
end
