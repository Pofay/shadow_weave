defmodule ShadowWeave.OwlbearController do
  alias ShadowWeave.Owlbear
  alias ShadowWeave.OwlbearView
  alias ShadowWeave.Conn
  alias ShadowWeave.OwlbearSanctuary

  @template_path Path.expand("../../templates", __DIR__)

  def index(%Conn{} = conv) do
    owlbears =
      OwlbearSanctuary.all_owlbears()
      |> Enum.sort(&Owlbear.order_ascending/2)

    render(conv, "index.eex", owlbears: owlbears)
  end

  def show(%Conn{} = conv, %{"id" => id}) do
    owlbear = OwlbearSanctuary.get_owlbear(id)

    render(conv, "show.eex", owlbear: owlbear)
  end

  def create(%Conn{} = conv, params) do
    %Conn{
      conv
      | resp_body: "Created a #{params["type"]} Owlbear named #{params["name"]}!",
        status: 201
    }
  end

  def delete(%Conn{} = conv, %{"id" => id}) do
    owlbear = OwlbearSanctuary.get_owlbear(id)

    %Conn{
      conv
      | resp_body: "You do not have the strength to kill Owlbear #{owlbear.id}: #{owlbear.name}.",
        status: 403
    }
  end

  defp render(%Conn{} = conv, template, bindings \\ []) do
    content =
      case template do
        "index.eex" -> OwlbearView.index(bindings[:owlbears])
        "show.eex" -> OwlbearView.show(bindings[:owlbear])
        _ -> @template_path |> Path.join(template) |> EEx.eval_file(bindings)
      end

    %Conn{conv | resp_body: content, status: 200}
  end
end
