defmodule Communote.Comments do
  @moduledoc """
  The Comments context.
  """

  import Ecto.Query, warn: false
  alias Communote.Repo

  alias Communote.Comments.Comment

  @doc """
  Returns the list of comment.

  ## Examples

      iex> list_comment()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Returns the list of comment for a given note_id.

  ## Examples

      iex> list_comment_for_note_id(note_id)
      [%Comment{}, ...]

  """
  def list_comments_by_note_id(note_id) do
    query = from c in Comment,
            where: c.note_id == ^note_id
    Repo.all(query)
  end



  @doc """
  Returns the list of comment for a given note_id.

  ## Examples

      iex> list_comment_for_note_id(note_id)
      [%Comment{}, ...]

  """
  def list_comments_by_note_id_with_preloaded_user(note_id) do
    query = from c in Comment,
            where: c.note_id == ^note_id,
            preload: [:user],
            order_by: [desc: :inserted_at]
    Repo.all(query)
  end

  @doc """
  Gets a single comment by looking for its id.

  ## Examples

      iex> get_comment_with_preloaded_user(comment_id)
      %Comment

  """
  def get_comment_with_preloaded_user(comment_id) do
    query = from c in Comment,
            where: c.id == ^comment_id,
            preload: [:user]
    Repo.one(query)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
