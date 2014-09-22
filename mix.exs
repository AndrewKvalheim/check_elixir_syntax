defmodule CheckElixirSyntax.Mixfile do
  use Mix.Project

  def project do
    [app: :check_elixir_syntax,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     escript: escript,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  defp escript do
    [main_module: CheckElixirSyntax]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [poison: "~> 1.2.0"]
  end
end
