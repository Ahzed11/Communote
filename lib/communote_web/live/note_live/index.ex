defmodule CommunoteWeb.NoteLive.Index do
  use CommunoteWeb, :live_view

  alias Communote.Notes

  @impl true
  def mount(%{"code" => code} = _params, _session, socket) do
    {:ok,
      socket
      |> assign(:notes, list_notes(code))
      |> assign(:code, code)}
  end

  def mount(%{"slug" => _slug} = _params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Notes")
    |> assign(:note, nil)
  end

  defp list_notes(code) do
    Notes.list_notes_by_course_code(code)
  end
end
