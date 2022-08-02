defmodule CommunoteWeb.ReportLive.FormComponent do
  use CommunoteWeb, :live_component

  alias Communote.Reports

  @impl true
  def update(%{report: report} = assigns, socket) do
    changeset = Reports.change_report(report)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"report" => report_params}, socket) do
    changeset =
      socket.assigns.report
      |> Reports.change_report(report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"report" => report_params}, socket) do
    save_report(socket, socket.assigns.action, report_params)
  end

  defp save_report(socket, :new_report, report_params) do
    report = Map.put(report_params, "user_id", socket.assigns.current_user.id) |> Map.put("note_id", socket.assigns.note.id)
    case Reports.create_report(report) do
      {:ok, _report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Report created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
