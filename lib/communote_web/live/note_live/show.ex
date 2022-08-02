defmodule CommunoteWeb.NoteLive.Show do
  use CommunoteWeb, :live_view

  alias Communote.Notes
  alias Communote.Accounts
  alias Communote.Reports.Report

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug} = params, _, socket) do
    note = Notes.get_note_by_slug(slug)
    socket_with_note_and_title = assign(socket, :note, note) |> assign(:page_title, page_title(socket.assigns.live_action))

    {:noreply, apply_action(socket_with_note_and_title, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, _params) do
    presigned_url = Notes.get_note_file_presigned_url(socket.assigns.note.filename, :get)

    assign(socket, :presigned_url, presigned_url)
  end

  defp apply_action(socket, :edit, %{"slug" => slug}) do
    socket
  end

  @impl true
  defp apply_action(socket, :new_report, %{"slug" => slug}) do
    assign(socket, :report, %Report{})
  end

  @impl true
  def handle_event("delete", %{"slug" => slug}, socket) do
    note = Notes.get_note_by_slug(slug)

    if Accounts.owns?(socket.assigns.current_user, note) do
      {:ok, _} = Notes.delete_note(note)
    end

    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Note"
  defp page_title(:edit), do: "Edit Note"
  defp page_title(:new_report), do: "New Report"
end
