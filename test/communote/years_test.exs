defmodule Communote.YearsTest do
  use Communote.DataCase

  alias Communote.Years

  describe "years" do
    alias Communote.Years.Year

    import Communote.YearsFixtures

    @invalid_attrs %{year: nil}

    test "list_years/0 returns all years" do
      year = year_fixture()
      assert Years.list_years() == [year]
    end

    test "get_year!/1 returns the year with given id" do
      year = year_fixture()
      assert Years.get_year!(year.id) == year
    end

    test "create_year/1 with valid data creates a year" do
      valid_attrs = %{year: "some year"}

      assert {:ok, %Year{} = year} = Years.create_year(valid_attrs)
      assert year.year == "some year"
    end

    test "create_year/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Years.create_year(@invalid_attrs)
    end

    test "update_year/2 with valid data updates the year" do
      year = year_fixture()
      update_attrs = %{year: "some updated year"}

      assert {:ok, %Year{} = year} = Years.update_year(year, update_attrs)
      assert year.year == "some updated year"
    end

    test "update_year/2 with invalid data returns error changeset" do
      year = year_fixture()
      assert {:error, %Ecto.Changeset{}} = Years.update_year(year, @invalid_attrs)
      assert year == Years.get_year!(year.id)
    end

    test "delete_year/1 deletes the year" do
      year = year_fixture()
      assert {:ok, %Year{}} = Years.delete_year(year)
      assert_raise Ecto.NoResultsError, fn -> Years.get_year!(year.id) end
    end

    test "change_year/1 returns a year changeset" do
      year = year_fixture()
      assert %Ecto.Changeset{} = Years.change_year(year)
    end
  end
end
