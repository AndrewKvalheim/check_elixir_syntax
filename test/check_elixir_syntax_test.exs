defmodule CheckElixirSyntaxTest do
  import ExUnit.CaptureIO
  use ExUnit.Case
  import CheckElixirSyntaxTest.Helper

  #
  # Metadata
  #

  test "Report a version number" do
    version = run(["--version"])
    assert version =~ ~r/\d+\.\d+\.\d+/
  end

  #
  # Valid input
  #

  @nothing Poison.Parser.parse!(~s([]))

  test "When the file is empty, report nothing." do
    assert fixture("empty") == @nothing
  end

  test "When the standard input is empty, report nothing." do
    assert fixture("empty", :stdio) == @nothing
  end

  test "When the file is valid, report nothing." do
    assert fixture("valid") == @nothing
  end

  #
  # Syntax errors
  #

  @single_syntax_error Poison.Parser.parse!(~s([{
    "line": 3,
    "message": "invalid token: :123",
    "token": ":123",
    "type": "error"
  }]))

  test "When the file contains one syntax error, report it." do
    assert fixture("single_syntax_error") == @single_syntax_error
  end

  test "When the file contains multiple syntax errors, report the first." do
    assert fixture("multiple_syntax_errors") == @single_syntax_error
  end

  test "When the standard input contains one syntax error, report it." do
    assert fixture("single_syntax_error", :stdio) == @single_syntax_error
  end
end
