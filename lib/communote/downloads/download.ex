defmodule Communote.Downloads.Download do
  use Ecto.Schema
  import Ecto.Changeset
  alias Communote.Accounts.User
  alias Communote.Notes.Note

  schema "downloads" do

    belongs_to(:user, User)
    belongs_to(:note, Note)

    timestamps()
  end

  @doc false
  def changeset(download, attrs) do
    download
    |> cast(attrs, [:user_id, :note_id])
    |> validate_required([:user_id, :note_id])
  end
end
