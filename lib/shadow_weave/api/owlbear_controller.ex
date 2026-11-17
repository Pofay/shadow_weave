defmodule ShadowWeave.Api.OwlbearController do
  def index(conv) do
    json =
      ShadowWeave.OwlbearSanctuary.all_owlbears()
      |> Jason.encode!()

    %{conv | status: 200, resp_body: json, resp_headers: %{"Content-Type" => "application/json"}}
  end
end
