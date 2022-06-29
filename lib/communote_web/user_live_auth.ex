defmodule CommunoteWeb.UserLiveAuth do
  import Phoenix.LiveView
  alias Communote.Accounts

  def on_mount(:default, _params, %{"user_token" => user_token} = _session, socket) do
    socket = assign_new(socket, :current_user, fn ->
      Accounts.get_user_by_session_token(user_token)
    end)

    if socket.assigns.current_user do
      {:cont, socket}
    else
      redirect(socket)
    end
  end

  def on_mount(:default, _params, _session, socket) do
    redirect(socket)
  end

  defp redirect(socket), do: {:halt, redirect(socket, to: "/users/log_in")}
end
