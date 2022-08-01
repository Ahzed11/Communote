defmodule CommunoteWeb.NoteController do
  use CommunoteWeb, :controller
  alias Communote.Notes

  def download(conn, %{"slug" => slug} = _params) do
    # TODO: CREATE DOWNLOAD ENTITY
    note = Notes.get_note_by_slug(slug)

    conn
    |> redirect(external: Notes.get_note_file_presigned_url(note.filename, :get))
  end
end
