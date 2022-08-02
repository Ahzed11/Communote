defmodule Communote.Reviews.ReviewAdmin do
  alias Communote.Reviews

  def widgets(_schema, _conn) do
    [
      %{
        type: "chart",
        title: "Reviews",
        content: %{
          x: ["1", "2", "3", "4", "5"],
          y: Reviews.count_reviews_by_score(),
          y_title: "Score"
        },
        width: 4
      },
      %{
        type: "tidbit",
        title: "Average score of reviews",
        content: Decimal.to_string(Reviews.get_average_score(), :xsd),
        icon: "thumbs-up",
        order: 5,
        width: 2,
      }
    ]
  end
end
