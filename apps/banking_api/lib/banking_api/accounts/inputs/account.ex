defmodule BankingApi.Accounts.Inputs.Account do
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
    |> validate_number(:balance, greater_than_or_equal_to: 0)
  end
end
