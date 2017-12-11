defmodule Margaret.Repo.Migrations.AddStarsTable do
  @moduledoc false

  use Ecto.Migration

  @doc false
  def change do
    create table(:stars) do
      add :user_id, references(:users), null: false

      add :story_id, references(:stories)
      add :comment_id, references(:comments)

      timestamps()
    end

    create unique_index(:stars, [:user_id, :story_id])
    create unique_index(:stars, [:user_id, :comment_id])

    create constraint(
      :stars,
      :only_one_not_null_starrable,
      check:
      "story_id is not null and comment_id is null or story_id is null and comment_id is not null")
  end
end
