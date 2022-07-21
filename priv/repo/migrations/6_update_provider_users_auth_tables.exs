defmodule Communote.Repo.Migrations.UpdateUsersAuthTablesWithProvider do
  use Ecto.Migration

  def change do

    alter table(:users) do
      add :provider, :string
    end
  end
end
