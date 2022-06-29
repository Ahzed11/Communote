defmodule Communote.Years.Year do
  use Ecto.Schema
  import Ecto.Changeset
  alias Communote.Notes.Note

  schema "years" do
    field :year, :string
    has_many(:notes, Note)

    timestamps()
  end

  @doc false
  def changeset(year, attrs) do
    year
    |> cast(attrs, [:year])
    |> validate_required([:year])
    |> unique_constraint(:year)
  end
end
