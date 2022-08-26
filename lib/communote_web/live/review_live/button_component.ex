defmodule CommunoteWeb.ReviewLive.ButtonComponent do
  use CommunoteWeb, :live_component

  alias Communote.Reviews

  @impl true
  def update(%{review: review} = assigns, socket) do
    score = case review do
      nil -> 0
      review -> review.score
    end

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:score, score)
     |> assign(:star_class, &star_class/2)}
  end

  @impl true
  def handle_event("clicked", %{"score" => score}, socket) do
    save_review(socket, String.to_integer(score))
  end

  defp save_review(%{assigns: %{review: review, current_user: current_user, note: note}} = socket, score) when is_nil(review) do
    review_params = %{user_id: current_user.id, note_id: note.id, score: score}
    case Reviews.create_review(review_params) do
      {:ok, review} ->
        {:noreply,
         socket
         |> put_flash(:info, "Review created successfully")
         |> assign(:score, score)
         |> assign(:review, review)}

      {:error, %Ecto.Changeset{} = _changeset} ->
        {:noreply,
        socket
        |> put_flash(:error, "An error happened when creating the review")}
    end
  end

  defp save_review(%{assigns: %{review: review, current_user: current_user, note: note}} = socket, score) do
    review_params = %{id: review.id, user_id: current_user.id, note_id: note.id, score: score}
    case Reviews.update_review(socket.assigns.review, review_params) do
      {:ok, review} ->
        {:noreply,
         socket
         |> put_flash(:info, "Review updated successfully")
         |> assign(:score, score)
         |> assign(:review, review)}

      {:error, %Ecto.Changeset{} = _changeset} ->
        {:noreply,
        socket
        |> put_flash(:error, "An error happened when creating the review")}
    end
  end

  defp star_class(score, x) do
    base = "fas fa-star"
    if x <= score do
      "#{base} text-yellow-400"
    else
      "#{base} text-gray-100"
    end
  end
end
