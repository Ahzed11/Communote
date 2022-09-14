FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

COPY mix.exs .
COPY mix.lock .

CMD mix deps.get && mix ecto.create && mix ecto.migrate && mix phx.server
