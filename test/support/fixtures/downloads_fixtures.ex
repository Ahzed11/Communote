defmodule Communote.DownloadsFixtures do
  alias Communote.AccountFixtures
  alias Communote.NoteFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Communote.Downloads` context.
  """

  @doc """
  Generate a download.
  """
  def download_fixture(attrs \\ %{}) do
    user = AccountsFixtures.user_fixture()
    note = NoteFixtures.note_fixture()

    {:ok, download} =
      attrs
      |> Enum.into(%{
        user_id: user.id,
        note_id: note.id
      })
      |> Communote.Downloads.create_download()

    download
  end
end
