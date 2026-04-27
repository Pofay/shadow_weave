defmodule ShadowWeave.Conn do
  defstruct method: "", path: "", params: %{}, resp_body: "", status: nil

  def full_status(conn) do
    "#{conn.status} #{status_reason(conn.status)}"
  end

 defp status_reason(code) do
    %{
      200 => "OK",
      404 => "Not Found",
      403 => "Forbidden"
    }[code]
  end
end
