defmodule GuardianAuthWeb.UserController do
  use GuardianAuthWeb, :controller

  alias GuardianAuth.Accounts
  alias GuardianAuth.Accounts.User
  alias GuardianAuth.Repo

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case GuardianAuth.Registration.create(changeset, Repo) do
      {:ok, user} ->
        conn
        |> GuardianAuth.Auth.login(user)
        |> put_flash(:info, "Your account was created successfully")
        |> redirect(to: "/")

      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create account: Try again")
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = User.changeset(user)
    cond do
      user == Guardian.Plug.current_resource(conn) ->
        conn
        |> render("show.html", user: user, changeset: changeset)
      true ->
        conn
        |> put_flash(:info, "No access rights ")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = User.changeset(user)
    cond do
      user == Guardian.Plug.current_resource(conn) ->
        render conn, "edit.html", user: user,changeset: changeset
      true ->
        conn
        |> put_flash(:info, "No access to edit ")
        |> redirect(to: user_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)
    changeset = User.registration_changeset(user, user_params)
    cond do
      user == Guardian.Plug.current_resource(conn) ->
        case Repo.update(changeset) do
          {:ok, _user} ->
            conn
            |> put_flash(:info, "User updated")
            |> redirect(to: page_path(conn, :index,user: user))
          {:error, changeset} ->
            conn
            |> render("show.html", user: user, changeset: changeset)
        end

      true ->
        conn
        |> put_flash(:info, "No access")
        |> redirect(to: page_path(conn, :index))
    end

  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    cond do
      user == Guardian.Plug.current_resource(conn) ->
        case Repo.delete(user) do
          {:ok, _user} ->
            conn
            |> Guardian.Plug.sign_out
            |> put_flash(:info, "Account deleted")
            |> redirect(to: page_path(conn, :index))
          {:error, _} ->
            conn
            |> render("show.html", user: user)
        end
      true ->
        conn
        |> put_flash(:info, "No access")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
