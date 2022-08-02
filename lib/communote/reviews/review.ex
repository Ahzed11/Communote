defmodule Communote.Reviews.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias Communote.Accounts.User
  alias Communote.Notes.Note

  schema "reviews" do
    field :score, :integer
    belongs_to(:user, User)
    belongs_to(:note, Note)

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:score, :user_id, :note_id])
    |> validate_required([:score, :user_id, :note_id])
    |> validate_number(:score, [greater_than_or_equal_to: 1, less_than_or_equal_to: 5])
  end
end
