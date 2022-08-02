defmodule Communote.Accounts.UserAdmin do
  alias Communote.Accounts

  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Number of users",
        content: Accounts.get_user_count |> Integer.to_string(),
        icon: "user",
        order: 1,
        width: 2
      },
    ]
  end
end
