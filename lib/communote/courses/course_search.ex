defmodule Communote.Courses.CourseSearch do
  defstruct [:term]
  @types %{term: :string}

  alias Communote.Courses.CourseSearch
  import Ecto.Changeset

  def changeset(%CourseSearch{} = course_search, attrs) do
    {course_search, @types}
    |> cast(attrs, Map.keys(@types))
  end
end
