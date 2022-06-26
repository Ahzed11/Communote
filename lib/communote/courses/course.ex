defmodule Communote.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :code, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:title, :code])
    |> validate_required([:title, :code])
    |> unique_constraint(:code)
  end
end
