defmodule GuardianAuthWeb.SessionController do
  use GuardianAuthWeb, :controller
  
  def new(conn, _) do 
    if GuardianAuth.Session.logged_in?(conn), do: redirect(conn,to: "/"), else: render(conn,"new.html")
  end

  def create(conn, %{"session" => %{"email" => user, 
    "password" => pass}}) do
    IO.inspect user, label: "============THIS IS EMAIL================"
    case GuardianAuth.Auth.login_by_email_and_pass(conn, user, pass, repo: GuardianAuth.Repo) do
      {:ok, conn} ->
        user = Guardian.Plug.current_resource(conn)
        conn
        |> put_flash(:info, "Login Successful")
        |> redirect(to: user_path(conn, :show, user.id ))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Wrong username/password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Your session is end ")
    |> redirect(to: "/")
  end
end
