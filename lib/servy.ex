defmodule Servy do
  def hello(name) do
    "Hello, #{inspect(name)}!"
  end
end

IO.puts(Servy.hello("World"))
