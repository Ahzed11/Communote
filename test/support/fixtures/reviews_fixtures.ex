defmodule Communote.ReviewsFixtures do
  alias Communote.AccountFixtures
  alias Communote.NoteFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Communote.Reviews` context.
  """

  @doc """
  Generate a review.
  """
  def review_fixture(attrs \\ %{}) do
    user = AccountsFixtures.user_fixture()
    note = NoteFixtures.note_fixture()

    {:ok, review} =
      attrs
      |> Enum.into(%{
        user_id: user.id,
        note_id: note.id,
        score: 42
      })
      |> Communote.Reviews.create_review()

    review
  end
end
