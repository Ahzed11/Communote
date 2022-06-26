defmodule CommunoteWeb.CourseLiveTest do
  use CommunoteWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Index" do
    test "lists all courses", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.course_index_path(conn, :index))

      assert html =~ "Listing Courses"
    end
  end
end
