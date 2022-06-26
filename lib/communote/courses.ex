defmodule Communote.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias Communote.Repo

  alias Communote.Courses.Course
  alias Communote.Courses.CourseSearch

  @doc """
  Returns the list of courses.

  ## Examples

      iex> list_courses()
      [%Course{}, ...]

  """
  def list_courses do
    Repo.all(Course)
  end

  @doc """
  Returns the list of courses by searching them with FTS.
  ## Examples
      iex> list_courses_with_fts()
      [%Course{}, ...]
  """
  def list_courses_with_fts(term) when term == "" do
    list_courses_with_fts("LINFO")
  end

  def list_courses_with_fts(term) do
    query = Course |> where_term(term) |> order_by_most_relevant(term) |> limit(8)
    Repo.all(query)
  end

  defp where_term(query, term) do
    where(
      query,
      fragment(
        "document @@ to_tsquery(?)",
        ^prefix_search(term)
      )
    )
  end

  defp order_by_most_relevant(query, term) do
    order_by(
      query,
      fragment(
        "ts_rank(document, to_tsquery(?)) DESC",
        ^prefix_search(term)
      )
    )
  end

  defp prefix_search(term) do
    replaced = String.replace(term, ~r/\W/u, "") <> ":*"
    replaced
  end

  @doc """
  Gets a single course.

  Raises `Ecto.NoResultsError` if the Course does not exist.

  ## Examples

      iex> get_course!(123)
      %Course{}

      iex> get_course!(456)
      ** (Ecto.NoResultsError)

  """
  def get_course!(id), do: Repo.get!(Course, id)

  @doc """
  Creates a course.

  ## Examples

      iex> create_course(%{field: value})
      {:ok, %Course{}}

      iex> create_course(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a course.

  ## Examples

      iex> update_course(course, %{field: new_value})
      {:ok, %Course{}}

      iex> update_course(course, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a course.

  ## Examples

      iex> delete_course(course)
      {:ok, %Course{}}

      iex> delete_course(course)
      {:error, %Ecto.Changeset{}}

  """
  def delete_course(%Course{} = course) do
    Repo.delete(course)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking course changes.

  ## Examples

      iex> change_course(course)
      %Ecto.Changeset{data: %Course{}}

  """
  def change_course(%Course{} = course, attrs \\ %{}) do
    Course.changeset(course, attrs)
  end

  def change_course_search(%CourseSearch{} = course_search, attrs \\ %{}) do
    CourseSearch.changeset(course_search, attrs)
  end
end
