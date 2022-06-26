defmodule CommunoteWeb.CourseLive.Index do
  use CommunoteWeb, :live_view

  alias Communote.Courses
  alias Communote.Courses.CourseSearch

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:courses, [])
      |> assign_course_search()
      |> assign_changeset()
    }
  end

  defp assign_course_search(socket) do
    socket
    |> assign(:course_search, %CourseSearch{})
  end

  defp assign_changeset(%{assigns: %{course_search: course_search}} = socket) do
    socket
    |> assign(:changeset, Courses.change_course_search(course_search))
  end

  @impl true
  def handle_event("changed", %{"course_search" => course_search_params}, %{assigns: %{course_search: course_search}} = socket) do
    changeset = course_search |> Courses.change_course_search(course_search_params) |> Map.put(:action, "changed")
    courses = Courses.list_courses_with_fts(course_search_params["term"])

    {:noreply,
    socket
    |> assign(:changeset, changeset)
    |> assign(:courses, courses)
    }
  end
end
