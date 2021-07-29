defmodule BankingApi.Accounts.Inputs.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:from, :to, :value]

  @primary_key false
  embedded_schema do
    field :from, :string
    field :to, :string
    field :value, :integer
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_number(:value, greater_than_or_equal_to: 0)
  end
end
