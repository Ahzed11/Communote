defmodule Communote.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :note_id, references(:notes, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:comments, [:note_id])
    create index(:comments, [:user_id])
  end
end
