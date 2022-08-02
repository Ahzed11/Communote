defmodule Communote.ReportsFixtures do
  alias Communote.AccountFixtures
  alias Communote.NoteFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Communote.Reports` context.
  """

  @doc """
  Generate a report.
  """
  def report_fixture(attrs \\ %{}) do
    user = AccountsFixtures.user_fixture()
    note = NoteFixtures.note_fixture()

    {:ok, report} =
      attrs
      |> Enum.into(%{
        user_id: user.id,
        note_id: note.id,
        body: "some body"
      })
      |> Communote.Reports.create_report()

    report
  end
end
