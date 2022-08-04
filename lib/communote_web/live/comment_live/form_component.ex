defmodule CommunoteWeb.CommentLive.FormComponent do
  use CommunoteWeb, :live_component

  alias Communote.Comments
  alias Communote.Comments.Comment

  @impl true
  def update(%{comment: comment} = assigns, socket) do
    changeset = Comments.change_comment(comment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def update(assigns, socket) do
    comment = %Comment{}
    changeset = comment |> Comments.change_comment

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:comment, comment)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"comment" => comment_params}, socket) do
    changeset =
      socket.assigns.comment
      |> Comments.change_comment(comment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"comment" => comment_params}, socket) do
    save_comment(socket, socket.assigns.action, comment_params)
  end

  defp save_comment(socket, :new, comment_params) do
    comment = Map.put(comment_params, "user_id", socket.assigns.current_user.id) |> Map.put("note_id", socket.assigns.note.id)
    case Comments.create_comment(comment) do
      {:ok, _comment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Comment created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
