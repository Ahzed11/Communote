defmodule Communote.Repo.Migrations.CreateYears do
  use Ecto.Migration

  def change do
    create table(:years) do
      add :year, :string

      timestamps()
    end

    create unique_index(:years, [:year])
  end
end
