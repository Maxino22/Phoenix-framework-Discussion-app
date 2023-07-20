defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.{Topic, Topics}

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    topics = Topics.list_topics()

    conn
    |> render(:index, topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Topics.create_topic(topic) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Topic created success")
        |> redirect(to: ~p"/")

      # redirect
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Failed to create topic")
        |> render(:new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Topics.get_topic!(topic_id)
    changeset = Topics.change_topic(topic)

    render(conn, :edit, changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Topics.get_topic!(id)

    case Topics.update_topic(topic, topic_params) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic title updated successfully")
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Failed to update")
        |> render(:new, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Topics.get_topic!(id)
    {:ok, _topic} = Topics.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: ~p"/")
  end
end
