defmodule CommunoteWeb.CommentLive.CommentComponent do
  use CommunoteWeb, :live_component

  alias Communote.Comments
  alias Communote.Accounts

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(assigns, socket) do
    is_owner = Accounts.owns?(assigns.current_user, assigns.comment)

    {:ok,
      socket
      |> assign(assigns)
      |> assign(:is_owner, is_owner)}
  end

  def handle_event("delete", _params, socket) do
    comment = socket.assigns.comment
    if Accounts.owns?(socket.assigns.current_user, comment) do
      {:ok, _} = Comments.delete_comment(comment)
    end

    {:noreply, socket}
  end
end
