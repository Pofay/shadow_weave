defmodule ShadowWeave.Api.OwlbearController do
  def index(conv) do
    json =
      ShadowWeave.OwlbearSanctuary.all_owlbears()
      |> Jason.encode!()

    conv = put_resp_content_type(conv, "application/json")

    %{conv | status: 200, resp_body: json}
  end

  defp put_resp_content_type(%ShadowWeave.Conn{} = conv, content_type) do
    %ShadowWeave.Conn{conv | resp_headers: Map.put(conv.resp_headers, "Content-Type", content_type)}
  end
end
