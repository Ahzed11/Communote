defmodule CommunoteWeb.NoteLive.FormComponent do
  use CommunoteWeb, :live_component

  alias Communote.Notes
  alias Communote.Courses
  alias Communote.Years
  alias Communote.Accounts

  require Logger

  @impl Phoenix.LiveComponent
  def mount(socket) do
    {:ok,
    socket
    |> assign(:uploaded_files, [])
    |> allow_upload(:note_file, accept: ~w(.pdf), external: &presign_upload/2)}
  end

  @impl true
  def update(%{note: note} = assigns, socket) do
    changeset = Notes.change_note(note)
    years = Years.list_years() |> Years.enumerate()
    courses = if assigns.note.course_id do
      [Courses.get_course!(assigns.note.course_id)] |> Courses.enumerate()
    else
      []
    end

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:courses, courses)
     |> assign(:years, years)
    }
  end

  @impl true
  def handle_event("validate", %{"note" => note_params}, socket) do
    courses = if note_params["course_search"] != "" do
     Courses.list_courses_with_fts(note_params["course_search"]) |> Courses.enumerate()
    else
      if socket.assigns.note.course_id do
        [Courses.get_course!(socket.assigns.note.course_id)] |> Courses.enumerate()
      else
        []
      end
    end

    changeset =
      socket.assigns.note
      |> Notes.change_note(note_params)
      |> Map.put(:action, :validate)

    {:noreply,
      socket
      |> assign(:changeset, changeset)
      |> assign(:courses, courses)
    }
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :note_file, ref)}
  end

  def handle_event("save", %{"note" => note_params}, socket) do
    filename = consume_uploaded_entries(socket, :note_file, fn %{} = meta, _entry ->
      meta.key
    end) |> List.first

    save_note(socket, socket.assigns.action, note_params, filename)
  end

  defp save_note(socket, :edit, note_params, filename) do
    case Accounts.owns?(socket.assigns.current_user, socket.assigns.note) do
      true ->
        {:ok, _} = Notes.delete_note_file(socket.assigns.note)
        note = Map.put(note_params, "filename", filename)
        case Notes.update_note(socket.assigns.note, note) do
          {:ok, _note} ->
            {:noreply,
            socket
            |> put_flash(:info, "Note updated successfully")
            |> push_redirect(to: socket.assigns.return_to)}

          {:error, %Ecto.Changeset{} = changeset} -> {:noreply, assign(socket, :changeset, changeset)}
        end
      false ->
        {:noreply,
        socket
        |> put_flash(:error, "You do not own this resource")
        |> push_redirect(to: socket.assigns.return_to)}
    end
  end

  defp save_note(socket, :new, note_params, filename) do
    note = Map.put(note_params, "user_id", socket.assigns.current_user.id) |> Map.put("filename", filename)
    case Notes.create_note(note) do
      {:ok, note} ->
        {:noreply,
        socket
        |> put_flash(:info, "Note created successfully")
        |> push_redirect(to: Routes.note_show_path(socket, :show, note.slug))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp presign_upload(entry, socket) do
    bucket = System.fetch_env!("AWS_S3_BUCKET")
    key = "public/#{Slug.slugify(entry.client_name)}-#{Ecto.UUID.generate}.pdf"

    presigned_url = Notes.create_note_file_presigned_url(key, :put)
    meta = %{uploader: "S3", bucket: bucket, key: key, url: presigned_url}
    {:ok, meta, socket}
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
  defp error_to_string(:external_client_failure), do: "External error"

end
