defmodule ShadowWeave.OwlbearController do
  alias ShadowWeave.Conn

  def index(%Conn{} = conv) do
    %Conn{conv | resp_body: "Margot, Richter, Dario", status: 200}
  end

  def show(%Conn{} = conv, %{"id" => id}) do
    %Conn{conv | resp_body: "Owlbear #{id}", status: 200}
  end

  def create(%Conn{} = conv, params) do
    %Conn{conv | resp_body: "Created a #{params["type"]} Owlbear named #{params["name"]}!", status: 201}
  end
end
