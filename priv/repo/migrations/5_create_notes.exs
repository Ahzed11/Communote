defmodule Communote.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string
      add :description, :string
      add :small_description, :string
      add :slug, :string
      add :user_id, references(:users, on_delete: :nilify_all)
      add :year_id, references(:years, on_delete: :nilify_all)
      add :course_id, references(:courses, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:notes, [:slug])
    create index(:notes, [:user_id])
    create index(:notes, [:year_id])
    create index(:notes, [:course_id])
  end
end
