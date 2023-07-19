defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  alias Discuss.{Users, Repo}
  alias Discuss.User.User
  plug(Ueberauth)

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)

    singin(conn, changeset)
  end

  defp singin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> put_session(:user_id, user.id)
        |> redirect(to: ~p"/")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Something went on while trying to sign in")
        |> redirect(to: ~p"/")
    end
  end

  defp insert_or_update_user(changeset) do
    case Users.get_user_by_email(changeset.changes.email) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end
end
