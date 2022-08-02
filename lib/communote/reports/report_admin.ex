defmodule Communote.Reports.ReportAdmin do
  alias Communote.Reports

  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Number of reports",
        content: Reports.get_report_count |> Integer.to_string(),
        icon: "warning",
        order: 4,
        width: 2
      },
      %{
        type: "text",
        title: "Last report",
        content: case Reports.get_last_report() do
          nil -> "There is no report"
          report -> "#{report.body}\n Note id:#{report.note_id}\n User id id:#{report.user_id}"
        end,
        icon: "warning",
        width: 12
      },
    ]
  end
end
