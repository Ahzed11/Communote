defmodule CommunoteWeb.NoteLive.Show do
  use CommunoteWeb, :live_view

  alias Communote.Notes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:note, Notes.get_note_by_slug(slug))
    }
  end

  @impl true
  def handle_event("delete", %{"slug" => slug}, socket) do
    note = Notes.get_note_by_slug(slug)
    {:ok, _} = Notes.delete_note(note)

    {:noreply, socket}
  end


  defp page_title(:show), do: "Show Note"
  defp page_title(:edit), do: "Edit Note"
end
