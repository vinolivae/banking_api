defmodule BankingApi.Validation.ChangesetValidation do
  @doc """
    This function contains the validation for the Changesets.
  """
  @spec cast_and_apply(Module.t(), Map.t()) :: {:ok, Map.t()} | {:error, Ecto.Changeset.t()}
  def cast_and_apply(module, params) do
    case module.changeset(params) do
      %{valid?: true} = changeset ->
        {:ok, Ecto.Changeset.apply_changes(changeset)}

      %{valid?: false} = changeset ->
        {:error, changeset}
    end
  end
end
