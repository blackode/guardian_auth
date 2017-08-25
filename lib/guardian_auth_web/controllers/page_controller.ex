defmodule GuardianAuthWeb.PageController do
  use GuardianAuthWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
