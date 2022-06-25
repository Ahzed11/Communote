defmodule CommunoteWeb.PageController do
  use CommunoteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
