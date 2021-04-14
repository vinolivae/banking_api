defmodule BankingApi.Repo.Migrations.AccountsMigration do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :balance, :decimal

      add :user_id, references(:users, type: :uuid)
    end

    create constraint(:accounts, :balance_must_be_positive_or_zero, check: "balance >= 0")
  end

end
