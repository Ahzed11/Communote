defmodule Communote.Downloads.DownloadAdmin do
  alias Communote.Downloads

  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Number of downloads",
        content: Downloads.get_download_count |> Integer.to_string(),
        icon: "download",
        order: 3,
        width: 2,
      },
    ]
  end
end
