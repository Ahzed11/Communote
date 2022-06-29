defmodule CommunoteWeb.NoteLiveTest do
  use CommunoteWeb.ConnCase

  import Phoenix.LiveViewTest
  import Communote.NotesFixtures
  alias Communote.Courses

  @create_attrs %{description: "some description", slug: "some slug", small_description: "some small_description", title: "some title"}
  @update_attrs %{description: "some updated description", slug: "some updated slug", small_description: "some updated small_description", title: "some updated title"}
  @invalid_attrs %{description: nil, slug: nil, small_description: nil, title: nil}

  defp create_note(_) do
    note = note_fixture()
    %{note: note}
  end

  describe "Index" do
    setup [:create_note]

    test "lists all notes for a given course code", %{conn: conn, note: note} do
      course = Courses.get_course!(note.course_id)
      {:ok, _index_live, html} = live(conn, Routes.note_index_path(conn, :index, course.code))

      assert html =~ "Listing Notes"
      assert html =~ note.description
    end

    test "updates note in listing", %{conn: conn, note: note} do
      course = Courses.get_course!(note.course_id)
      {:ok, index_live, _html} = live(conn, Routes.note_index_path(conn, :index, course.code))

      assert index_live |> element("#note-#{note.id} a", "Edit") |> render_click() =~
               "Edit Note"

      assert_patch(index_live, Routes.note_index_path(conn, :edit, note, course.code))

      assert index_live
             |> form("#note-form", note: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#note-form", note: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.note_index_path(conn, :index, course.code))

      assert html =~ "Note updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes note in listing", %{conn: conn, note: note} do
      course = Courses.get_course!(note.course_id)
      {:ok, index_live, _html} = live(conn, Routes.note_index_path(conn, :index, course.code))

      assert index_live |> element("#note-#{note.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#note-#{note.id}")
    end
  end

  describe "Show" do
    setup [:create_note]

    test "displays note", %{conn: conn, note: note} do
      course = Courses.get_course!(note.course_id)
      {:ok, _show_live, html} = live(conn, Routes.note_show_path(conn, :show, course.code, note.slug))

      assert html =~ "Show Note"
      assert html =~ note.description
    end

    test "updates note within modal", %{conn: conn, note: note} do
      course = Courses.get_course!(note.course_id)
      {:ok, show_live, html} = live(conn, Routes.note_show_path(conn, :show, course.code, note.slug))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Note"

      assert_patch(show_live, Routes.note_show_path(conn, :edit, course.code, note.slug))

      assert show_live
             |> form("#note-form", note: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#note-form", note: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.note_show_path(conn, :show, course.code, note.slug))

      assert html =~ "Note updated successfully"
      assert html =~ "some updated description"
    end
  end
end
