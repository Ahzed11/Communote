defmodule Communote.Repo.Migrations.UpdateNoteTableWithFilename do
  use Ecto.Migration

  def change do

    alter table(:notes) do
      add :filename, :string, null: false
    end
  end
end
