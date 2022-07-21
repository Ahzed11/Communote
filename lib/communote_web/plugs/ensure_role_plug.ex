defmodule CommunoteWeb.Plugs.EnsureRolePlug do

  @moduledoc """
  This plug ensures that a user has a particular role before accessing a given route.
  """

  import Plug.Conn
  import Phoenix.Controller

  alias Communote.Accounts
  alias Communote.Accounts.User

  def init(config), do: config

  def call(conn, roles) do
    user_token = get_session(conn, :user_token)

    (user_token && Accounts.get_user_by_session_token(user_token))
    |> has_role?(roles)
    |> maybe_halt(conn)
  end

  defp has_role?(%User{} = user, roles) when is_list(roles),
    do: Enum.any?(roles, &has_role?(user, &1))

  defp has_role?(%User{roles: roles}, role), do: Enum.member?(roles, role)

  defp maybe_halt(true, conn), do: conn
  defp maybe_halt(_any, conn) do
    conn
    |> put_flash(:error, "Unauthorised")
    |> redirect(to: signed_in_path(conn))
    |> halt()
  end

  defp signed_in_path(_conn), do: "/users/settings"
end
