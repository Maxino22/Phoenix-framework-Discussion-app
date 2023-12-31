defmodule Discuss.Topics do
  alias Discuss.{Repo, Topic}

  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  def list_topics do
    Repo.all(Topic)
  end

  def get_topic!(id), do: Repo.get!(Topic, id)

  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  def change_topic(%Topic{} = topic, attrs \\ %{}) do
    Topic.changeset(topic, attrs)
  end
end
