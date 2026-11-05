defmodule ShadowWeave.ExampleMatches do
  def route(%{method: "GET", path: "/owlbears"} = conv) do
    %{conv | status: 200, resp_body: "OWLBEARS!"}
  end

  def route(%{method: "POST", path: "/owlbears"} = conv) do
    %{conv | status: 201, resp_body: "Created an OWLBEAR!"}
  end

  def route(%{method: "GET", path: "/owlbears/" <> id} = conv) do
    %{conv | status: 200, resp_body: "DARIUS THE OWLBEAR is OWLBEAR number #{id}"}
  end
end
