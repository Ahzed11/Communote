defmodule Communote.Downloads do
  @moduledoc """
  The Downloads context.
  """

  import Ecto.Query, warn: false
  alias Communote.Repo

  alias Communote.Downloads.Download

  @doc """
  Gets the number of downloads.

  ## Examples

      iex> get_download_count()
      10

  """
  def get_download_count() do
    query = from n in Download, select: count()
    Repo.one(query)
  end

  @doc """
  Returns the list of downloads.

  ## Examples

      iex> list_downloads()
      [%Download{}, ...]

  """
  def list_downloads do
    Repo.all(Download)
  end

  @doc """
  Gets a single download.

  Raises `Ecto.NoResultsError` if the Download does not exist.

  ## Examples

      iex> get_download!(123)
      %Download{}

      iex> get_download!(456)
      ** (Ecto.NoResultsError)

  """
  def get_download!(id), do: Repo.get!(Download, id)

  @doc """
  Creates a download.

  ## Examples

      iex> create_download(%{field: value})
      {:ok, %Download{}}

      iex> create_download(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_download(attrs \\ %{}) do
    %Download{}
    |> Download.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a download.

  ## Examples

      iex> update_download(download, %{field: new_value})
      {:ok, %Download{}}

      iex> update_download(download, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_download(%Download{} = download, attrs) do
    download
    |> Download.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a download.

  ## Examples

      iex> delete_download(download)
      {:ok, %Download{}}

      iex> delete_download(download)
      {:error, %Ecto.Changeset{}}

  """
  def delete_download(%Download{} = download) do
    Repo.delete(download)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking download changes.

  ## Examples

      iex> change_download(download)
      %Ecto.Changeset{data: %Download{}}

  """
  def change_download(%Download{} = download, attrs \\ %{}) do
    Download.changeset(download, attrs)
  end
end
