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

# conv1 = %{status: nil, path: "/owlbears", method: "GET", resp_body: ""}
# conv2 = %{status: nil, path: "/owlbears", method: "POST", resp_body: ""}
# conv3 = %{status: nil, path: "/owlbears/1", method: "GET", resp_body: ""}

# convs = [conv1, conv2, conv3]

# Enum.map(convs, &ShadowWeave.ExampleMatches.route/1)
# |> Enum.each(&IO.inspect/1)
