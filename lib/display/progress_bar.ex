defmodule Display.ProgressBar do
  @moduledoc false
  @progress_bar_length 30

  def progress_bar(%{current: current, total: total}) do
    arrow = calculate_progress(current, total) |> build_arrow
    progress_percentage = calculate_percentage(current, total)

    "|" <> String.pad_trailing(arrow, @progress_bar_length) <> "| #{current} of #{total} -> #{progress_percentage}% complete"
  end

  defp calculate_progress(current, total) do
    round(current / total * @progress_bar_length)
  end

  defp calculate_percentage(current, total) do
    Float.round(current / total * 100, 1)
  end

  defp build_arrow(0), do: ""

  defp build_arrow(length) do
    String.duplicate("=", length - 1) <> ">"
  end
end
