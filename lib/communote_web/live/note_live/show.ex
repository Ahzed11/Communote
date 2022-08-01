defmodule CommunoteWeb.NoteLive.Show do
  use CommunoteWeb, :live_view

  alias Communote.Notes
  alias Communote.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _, socket) do
    note = Notes.get_note_by_slug(slug)
    presigned_url = Notes.get_note_file_presigned_url(note.filename, :get)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:note, note)
     |> assign(:presigned_url, presigned_url)
    }
  end

  @impl true
  def handle_event("delete", %{"slug" => slug}, socket) do
    note = Notes.get_note_by_slug(slug)

    if Accounts.owns?(socket.assigns.current_user, note) do
      {:ok, _} = Notes.delete_note(note)
    end

    {:noreply, socket}
  end


  defp page_title(:show), do: "Show Note"
  defp page_title(:edit), do: "Edit Note"
end
