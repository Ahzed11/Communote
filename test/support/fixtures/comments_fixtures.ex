defmodule Communote.CommentsFixtures do
  alias Communote.AccountFixtures
  alias Communote.NoteFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Communote.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    user = AccountsFixtures.user_fixture()
    note = NoteFixtures.note_fixture()

    {:ok, comment} =
      attrs
      |> Enum.into(%{
        user_id: user.id,
        note_id: note.id,
        body: "some body"
      })
      |> Communote.Comments.create_comment()

    comment
  end
end
