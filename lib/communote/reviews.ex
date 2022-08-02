defmodule Communote.Reviews do
  @moduledoc """
  The Reviews context.
  """

  import Ecto.Query, warn: false
  alias Communote.Repo

  alias Communote.Reviews.Review

  @doc """
  Returns the list of reviews.

  ## Examples

      iex> list_reviews()
      [%Review{}, ...]

  """
  def list_reviews do
    Repo.all(Review)
  end

  @doc """
  Returns the number of reviews with for each score.

  ## Examples

      iex> count_reviews_by_score()
      [1, 2, 3, 4, 5]

  """
  def count_reviews_by_score() do
    query1 = from r in Review, select: count(), where: r.score == 1
    query2 = from r in Review, select: count(), where: r.score == 2
    query3 = from r in Review, select: count(), where: r.score == 3
    query4 = from r in Review, select: count(), where: r.score == 4
    query5 = from r in Review, select: count(), where: r.score == 5

    res1 = Repo.one(query1)
    res2 = Repo.one(query2)
    res3 = Repo.one(query3)
    res4 = Repo.one(query4)
    res5 = Repo.one(query5)

    [res1, res2, res3, res4, res5]
  end

  @doc """
  Returns the average score for all reviews

  ## Examples

      iex> get_average_score()
      2,4

  """
  def get_average_score() do
    query = from r in Review, select: avg(r.score)
    Repo.one(query)
  end

  @doc """
  Returns the average score for all reviews

  ## Examples

      iex> get_average_score()
      2,4

  """
  def get_review_by_user_and_note(user, note) do
    filters = [user_id: user.id, note_id: note.id]
    query = from r in Review, where: ^filters
    Repo.one(query)
  end

  @doc """
  Gets a single review.

  Raises `Ecto.NoResultsError` if the Review does not exist.

  ## Examples

      iex> get_review!(123)
      %Review{}

      iex> get_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_review!(id), do: Repo.get!(Review, id)

  @doc """
  Creates a review.

  ## Examples

      iex> create_review(%{field: value})
      {:ok, %Review{}}

      iex> create_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review.

  ## Examples

      iex> update_review(review, %{field: new_value})
      {:ok, %Review{}}

      iex> update_review(review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a review.

  ## Examples

      iex> delete_review(review)
      {:ok, %Review{}}

      iex> delete_review(review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking review changes.

  ## Examples

      iex> change_review(review)
      %Ecto.Changeset{data: %Review{}}

  """
  def change_review(%Review{} = review, attrs \\ %{}) do
    Review.changeset(review, attrs)
  end
end
