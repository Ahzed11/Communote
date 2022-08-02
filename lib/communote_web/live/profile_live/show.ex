defmodule CommunoteWeb.ProfileLive.Show do
  use CommunoteWeb, :live_view

  alias Communote.Accounts
  alias Communote.Notes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _, socket) do
    user = Accounts.get_user_by_slug(slug)
    notes = Notes.list_notes_by_user_id(user.id)

    {:noreply,
     socket
     |> assign(:page_title, "profile")
     |> assign(:user, user)
     |> assign(:notes, notes)
    }
  end
end
