ExUnit.start()

defmodule CheckElixirSyntaxTest.Helper do
  import ExUnit.CaptureIO
  alias CheckElixirSyntax, as: CES

  def fixture(name),           do: json([fixture_path(name)])
  def fixture(name, :stdio),   do: json([], File.read!(fixture_path(name)))
  def json(args, stdin \\ ""), do: run(args, stdin) |> Poison.Parser.parse!
  def run(args, stdin \\ ""),  do: capture_io(stdin, fn -> CES.main(args) end)

  defp fixture_path(name), do: "fixtures/#{ name }.ex"
end
