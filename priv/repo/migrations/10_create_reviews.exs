defmodule Communote.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :score, :integer
      add :user_id, references(:users, on_delete: :nilify_all)
      add :note_id, references(:notes, on_delete: :delete_all)

      timestamps()
    end

    create index(:reviews, [:user_id])
    create index(:reviews, [:note_id])
  end
end
