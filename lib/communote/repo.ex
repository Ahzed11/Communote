defmodule Communote.Repo do
  use Ecto.Repo,
    otp_app: :communote,
    adapter: Ecto.Adapters.Postgres
end
