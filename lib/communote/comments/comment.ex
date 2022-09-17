defmodule Communote.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Communote.Accounts.User
  alias Communote.Notes.Note

  schema "comments" do
    field :body, :string
    belongs_to(:user, User)
    belongs_to(:note, Note)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :user_id, :note_id])
    |> validate_required([:body, :user_id, :note_id])
  end
end
