defmodule ShadowWeave.OwlbearSanctuary do
  alias ShadowWeave.Owlbear

  def all_owlbears do
    [
      %Owlbear{id: 1, name: "Margot", type: "Forest", aggressive: false},
      %Owlbear{id: 2, name: "Richter", type: "Mountain", aggressive: true},
      %Owlbear{id: 3, name: "Dario", type: "Swamp", aggressive: false},
      %Owlbear{id: 4, name: "Sophie", type: "Cave", aggressive: true},
      %Owlbear{id: 5, name: "Luna", type: "Forest", aggressive: false},
      %Owlbear{id: 6, name: "Gideon", type: "Mountain", aggressive: true},
      %Owlbear{id: 7, name: "Isabella", type: "Swamp", aggressive: false},
      %Owlbear{id: 8, name: "Aurora", type: "Cave", aggressive: true}
    ]
  end

  def get_owlbear(id) when is_integer(id) do
    Enum.find(all_owlbears(), fn owlbear -> owlbear.id == id end)
  end

  def get_owlbear(id) when is_binary(id) do
    id
    |> String.to_integer()
    |> get_owlbear()
  end
end
