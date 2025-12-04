defmodule ShadowWeaveTest do
  use ExUnit.Case
  doctest ShadowWeave

  test "greets the world" do
    assert Servy.hello() == :world
  end
end
