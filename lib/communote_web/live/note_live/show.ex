defmodule CommunoteWeb.NoteLive.Show do
  use CommunoteWeb, :live_view

  alias Communote.Notes
  alias Communote.Accounts
  alias Communote.Reports.Report
  alias Communote.Reviews
  alias Communote.Comments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug} = params, _, socket) do
    note = Notes.get_note_by_slug(slug)
    comments = Comments.list_comments_by_note_id_with_preloaded_user(note.id)
    new_socket =
      socket
      |> assign(:note, note)
      |> assign(:comments, comments)
      |> assign(:page_title, page_title(socket.assigns.live_action, note))

    {:noreply, apply_action(new_socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, _params) do
    presigned_url = Notes.get_note_file_presigned_url(socket.assigns.note.filename)
    review = Reviews.get_review_by_user_and_note(socket.assigns.current_user, socket.assigns.note)

    socket
      |> assign(:presigned_url, presigned_url)
      |> assign(:review, review)
  end

  defp apply_action(socket, :edit, _params) do
    socket
  end

  defp apply_action(socket, :new_report, _params) do
    assign(socket, :report, %Report{})
  end

  @impl true
  def handle_event("delete", _params, socket) do
    note = socket.assigns.note
    if Accounts.owns?(socket.assigns.current_user, note) do
      {:ok, _} = Notes.delete_note(note)
    end

    {:noreply, socket}
  end

  @impl true
  def handle_info({:new_comment, comment}, socket) do
    comments = [comment | socket.assigns.comments]
    {:noreply,
      socket
      |> assign(:comments, comments)}
  end

  @impl true
  def handle_info({:delete_comment, comment}, socket) do
    comments = List.delete(socket.assigns.comments, comment)
    {:noreply,
      socket
      |> assign(:comments, comments)}
  end


  defp page_title(:show, note), do: note.title
  defp page_title(:edit, note), do: "Edit - #{note.title}"
  defp page_title(:new_report, note), do: "New Report - #{note.title}"
end
