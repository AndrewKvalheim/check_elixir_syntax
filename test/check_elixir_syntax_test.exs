defmodule CheckElixirSyntaxTest do
  @nothing Poison.Parser.parse!(~s([]))
  @single_syntax_error Poison.Parser.parse!(~s([{
    "line": 3,
    "message": "invalid token: :123",
    "token": ":123",
    "type": "error"
  }]))

  import ExUnit.CaptureIO
  use ExUnit.Case
  alias CheckElixirSyntax, as: CES

  test "Report a version number" do
    version = capture_io(fn -> CES.main(["--version"]) end)
    assert version =~ ~r/\d+\.\d+\.\d+/
  end

  test "When the file is empty, report nothing." do
    assert check_file("empty") == @nothing
  end

  test "When the standard input is empty, report nothing." do
    assert check_stdin("empty") == @nothing
  end

  test "When the file is valid, report nothing." do
    assert check_file("valid") == @nothing
  end

  test "When the file contains one syntax error, report it." do
    assert check_file("single_syntax_error") == @single_syntax_error
  end

  test "When the file contains multiple syntax errors, report the first." do
    assert check_file("multiple_syntax_errors") == @single_syntax_error
  end

  test "When the standard input contains one syntax error, report it." do
    assert check_stdin("single_syntax_error") == @single_syntax_error
  end

  defp check_file(name) do
    capture_io(fn -> CES.main([fixture_path(name)]) end)
    |> Poison.Parser.parse!
  end

  defp fixture_path(name) do
    "fixtures/#{ name }.ex"
  end

  defp check_stdin(name) do
    capture_io(File.read!(fixture_path(name)), fn -> CES.main([]) end)
    |> Poison.Parser.parse!
  end
end
