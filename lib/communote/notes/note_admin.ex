defmodule Communote.Notes.NoteAdmin do
  alias Communote.Notes

  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Number of notes",
        content: Notes.get_note_count |> Integer.to_string(),
        icon: "pen",
        order: 1,
        width: 6,
      },
    ]
  end
end
