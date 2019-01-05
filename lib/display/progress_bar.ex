defmodule Display.ProgressBar do
  @progress_bar_length 30

  def progress_bar(%{current: current, total: total}) do
    arrow = calculate_progress(current, total) |> build_arrow

    "|" <> String.pad_trailing(arrow, @progress_bar_length) <> "| #{current} of #{total}"
  end

  defp calculate_progress(current, total) do
    round(current / total * @progress_bar_length)
  end

  defp build_arrow(0), do: ""

  defp build_arrow(length) do
    String.duplicate("=", length - 1) <> ">"
  end
end
