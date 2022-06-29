defmodule Communote.NotesTest do
  use Communote.DataCase

  alias Communote.Notes

  describe "notes" do
    alias Communote.Notes.Note
    alias Communote.AccountsFixtures
    alias Communote.CoursesFixtures
    alias Communote.YearsFixtures

    import Communote.NotesFixtures

    @invalid_attrs %{description: nil, slug: nil, small_description: nil, title: nil}

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Notes.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Notes.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      user = AccountsFixtures.user_fixture()
      course = CoursesFixtures.course_fixture()
      year = YearsFixtures.year_fixture()
      valid_attrs = %{description: "some description", slug: "some slug", small_description: "some small_description", title: "some title", user_id: user.id, course_id: course.id, year_id: year.id}

      assert {:ok, %Note{} = note} = Notes.create_note(valid_attrs)
      assert note.description == "some description"
      assert note.slug == "some-title"
      assert note.small_description == "some small_description"
      assert note.title == "some title"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notes.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      update_attrs = %{description: "some updated description", slug: "some updated slug", small_description: "some updated small_description", title: "some updated title"}

      assert {:ok, %Note{} = note} = Notes.update_note(note, update_attrs)
      assert note.description == "some updated description"
      assert note.slug == "some-title"
      assert note.small_description == "some updated small_description"
      assert note.title == "some updated title"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Notes.update_note(note, @invalid_attrs)
      assert note == Notes.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Notes.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Notes.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Notes.change_note(note)
    end
  end
end
