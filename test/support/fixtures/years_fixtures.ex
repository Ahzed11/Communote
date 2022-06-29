defmodule Communote.YearsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Communote.Years` context.
  """

  @doc """
  Generate a year.
  """
  def year_fixture(attrs \\ %{}) do
    {:ok, year} =
      attrs
      |> Enum.into(%{
        year: "2020 - 2021"
      })
      |> Communote.Years.create_year()

    year
  end
end
