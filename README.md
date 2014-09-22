# CheckElixirSyntax

Reports [Elixir][elixir] syntax errors as JSON.

## Installation

In the project directory, install dependencies and build the escript:

```bash
mix deps.get
MIX_ENV=prod mix escript.build
```

Ensure that `check_elixir_syntax` is in your `PATH`.

## Usage

Check a file for syntax errors:

```console
$ cat sample.ex
2 + 2)
$ check_elixir_syntax sample.ex
[{"type":"error","token":")","message":"unexpected token: )","line":1}]
```

Check standard input for syntax errors:

```console
$ echo '%{12factor: true}' | check_elixir_syntax
[{"type":"error","token":"factor","message":"syntax error before: factor","line":1}]
```


 [elixir]: http://elixir-lang.org/ 
