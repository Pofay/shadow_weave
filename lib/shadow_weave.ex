defmodule ShadowWeave do
  def hello(name) do
    "Hello, #{inspect(name)}!"
  end
end

IO.puts(ShadowWeave.hello("World"))
