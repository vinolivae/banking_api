defmodule BankingApi.Accounts.Inputs.Withdraw do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:id, :value]

  @primary_key false
  embedded_schema do
    field :id, :string
    field :value, :integer
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_number(:value, greater_than_or_equal_to: 0)
  end
end
