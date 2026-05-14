defmodule ShadowWeave.OwlbearController do
  alias ShadowWeave.Owlbear
  alias ShadowWeave.Conn
  alias ShadowWeave.OwlbearSanctuary

  def index(%Conn{} = conv) do
    items =
      OwlbearSanctuary.all_owlbears()
      |> Enum.sort(&Owlbear.order_ascending/2)
      |> Enum.map_join(&owlbear_item/1)
      |> wrap_into_ul()

    %Conn{conv | resp_body: items, status: 200}
  end

  def show(%Conn{} = conv, %{"id" => id}) do
    owlbear = OwlbearSanctuary.get_owlbear(id)
    %Conn{conv | resp_body: "<h1>Owlbear - #{owlbear.id}: #{owlbear.name}</h1>", status: 200}
  end

  def create(%Conn{} = conv, params) do
    %Conn{
      conv
      | resp_body: "Created a #{params["type"]} Owlbear named #{params["name"]}!",
        status: 201
    }
  end

  defp owlbear_item(owlbear), do: "<li>#{owlbear.name} - #{owlbear.type}</li>"

  defp wrap_into_ul(items) do
    "<ul>#{items}</ul>"
  end
end
