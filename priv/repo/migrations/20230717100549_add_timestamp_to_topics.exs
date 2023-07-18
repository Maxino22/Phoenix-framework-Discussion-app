defmodule Discuss.Repo.Migrations.AddTimestampToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      timestamps()
    end
  end
end
