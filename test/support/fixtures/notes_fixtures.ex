defmodule Communote.NotesFixtures do
  alias Communote.AccountsFixtures
  alias Communote.CoursesFixtures
  alias Communote.YearsFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Communote.Notes` context.
  """

  @doc """
  Generate a unique note slug.
  """
  def unique_note_slug, do: "some slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a note.
  """
  def note_fixture(attrs \\ %{}) do
    user = AccountsFixtures.user_fixture()
    course = CoursesFixtures.course_fixture()
    year = YearsFixtures.year_fixture()

    {:ok, note} =
      attrs
      |> Enum.into(%{
        description: "some description",
        slug: unique_note_slug(),
        small_description: "some small_description",
        title: "some title",
        user_id: user.id,
        course_id: course.id,
        year_id: year.id
      })
      |> Communote.Notes.create_note()

    note
  end
end
