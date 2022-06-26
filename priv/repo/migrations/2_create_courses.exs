defmodule Communote.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :title, :string, null: false
      add :code, :string, null: false

      timestamps()
    end

    create unique_index(:courses, [:code])
  end
end
