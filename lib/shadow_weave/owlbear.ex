defmodule ShadowWeave.Owlbear do
  defstruct id: nil, name: "", type: "", aggressive: false

  def order_ascending(o1, o2) do
    o1.name <= o2.name
  end
end
