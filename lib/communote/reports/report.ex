defmodule Communote.Reports.Report do
  use Ecto.Schema
  import Ecto.Changeset
  alias Communote.Accounts.User
  alias Communote.Notes.Note

  schema "reports" do
    field :body, :string
    belongs_to(:user, User)
    belongs_to(:note, Note)

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:body, :user_id, :note_id])
    |> validate_required([:body, :user_id, :note_id])
  end
end
