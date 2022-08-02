defmodule Communote.Repo.Migrations.CreateDownloads do
  use Ecto.Migration

  def change do
    create table(:downloads) do
      add :user_id, references(:users, on_delete: :nilify_all)
      add :note_id, references(:notes, on_delete: :nilify_all)

      timestamps()
    end

    create index(:downloads, [:user_id])
    create index(:downloads, [:note_id])
  end
end
