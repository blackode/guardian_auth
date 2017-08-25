defmodule GuardianAuth.HttpErrorHandler do
  use GuardianAuthWeb,:controller
  @doc """
  This function  handle the unauthorized login 
  """
  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> put_flash(:info, "You must be signed in to access this page")
    |> redirect(to: session_path(conn, :new))
  end

  def unauthorized(conn, _params) do
    conn
    |> put_flash(:error, "You must be signed in to access this page")
    |> redirect(to: session_path(conn, :new))
  end

end
