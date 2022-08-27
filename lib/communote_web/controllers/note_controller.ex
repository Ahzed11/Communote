defmodule CommunoteWeb.NoteController do
  use CommunoteWeb, :controller
  alias Communote.Notes
  alias Communote.Downloads

  def download(%{assigns: %{current_user: current_user}} = conn, %{"slug" => slug} = _params) do
    note = Notes.get_note_by_slug(slug)
    {:ok, _} = %{user_id: current_user.id, note_id: note.id} |> Downloads.create_download

    conn
    |> redirect(external: Notes.get_note_file_presigned_url(note.filename))
  end
end
