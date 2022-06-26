defmodule Communote.CoursesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Communote.Courses` context.
  """

  @doc """
  Generate a unique course code.
  """
  def unique_course_code, do: "some code#{System.unique_integer([:positive])}"

  @doc """
  Generate a course.
  """
  def course_fixture(attrs \\ %{}) do
    {:ok, course} =
      attrs
      |> Enum.into(%{
        code: unique_course_code(),
        title: "some title"
      })
      |> Communote.Courses.create_course()

    course
  end
end
