defmodule Communote.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :body, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :note_id, references(:notes, on_delete: :delete_all)

      timestamps()
    end

    create index(:reports, [:user_id])
    create index(:reports, [:note_id])
  end
end
