defmodule CheckElixirSyntax do
  @version "0.0.1"

  #
  # Routing
  #

  def main(args) do
    route OptionParser.parse(args, strict: [version: :boolean])
  end

  defp route({[version: true], _, _}), do: IO.puts @version
  defp route({[], paths, _}),          do: check paths: paths

  #
  # Syntax checking and reporting
  #

  defp check(paths: []),     do: check code: IO.read(:stdio, :all)
  defp check(paths: [path]), do: check code: File.read!(path)
  defp check(code: code),    do: code |> Code.string_to_quoted
                                      |> format_results
                                      |> Poison.Encoder.encode([])
                                      |> IO.puts

  defp format_results({:ok, _}),                         do: []
  defp format_results({:error, {line, message, token}}), do: [%{
    line:    line,
    message: message <> token,
    token:   token,
    type:    :error
  }]
end
