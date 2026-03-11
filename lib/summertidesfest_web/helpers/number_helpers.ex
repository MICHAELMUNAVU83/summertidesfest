defmodule SummertidesfestWeb.NumberHelpers do
  def format_ksh(amount) when is_integer(amount) do
    "KSH #{amount |> Integer.to_string() |> insert_commas()}"
  end

  def format_ksh(amount) when is_float(amount) do
    format_ksh(round(amount))
  end

  def format_ksh(nil), do: "KSH 0"

  defp insert_commas(str) do
    str
    |> String.reverse()
    |> String.graphemes()
    |> Enum.chunk_every(3)
    |> Enum.join(",")
    |> String.reverse()
  end
end
