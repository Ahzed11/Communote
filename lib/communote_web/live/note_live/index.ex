defmodule CommunoteWeb.NoteLive.Index do
  use CommunoteWeb, :live_view

  alias Communote.Notes
  alias Communote.Notes.Note

  @impl true
  def mount(%{"code" => code} = _params, _session, socket) do
    {:ok,
    socket
    |> assign(:notes, list_notes(code))
    |> assign(:code, code)
  }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"slug" => slug}) do
    socket
    |> assign(:page_title, "Edit Note")
    |> assign(:note, Notes.get_note_by_slug(slug))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Note")
    |> assign(:note, %Note{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Notes")
    |> assign(:note, nil)
  end

  @impl true
  def handle_event("delete", %{"slug" => slug}, socket) do
    note = Notes.get_note_by_slug(slug)
    {:ok, _} = Notes.delete_note(note)

    {:noreply, assign(socket, :notes, list_notes(socket.assigns.code))}
  end

  defp list_notes(code) do
    Notes.list_notes_by_course_code(code)
  end
end
