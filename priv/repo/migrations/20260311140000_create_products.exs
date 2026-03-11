defmodule Summertidesfest.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :description, :text
      add :price, :integer, null: false
      add :sizes, {:array, :string}, default: []
      add :images, {:array, :string}, default: []
      add :category, :string, null: false
      add :in_stock, :boolean, default: true
      add :stock_count, :integer, default: 0

      timestamps()
    end

    create index(:products, [:category])
    create index(:products, [:in_stock])
  end
end
