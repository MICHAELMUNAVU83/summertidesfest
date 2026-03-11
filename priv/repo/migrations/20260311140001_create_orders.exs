defmodule Summertidesfest.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :customer_name, :string, null: false
      add :customer_email, :string, null: false
      add :customer_phone, :string
      add :total, :integer, null: false
      add :status, :string, default: "pending"
      add :notes, :text
      add :reference, :string

      timestamps()
    end

    create index(:orders, [:status])
    create index(:orders, [:customer_email])
    create unique_index(:orders, [:reference])

    create table(:order_items) do
      add :order_id, references(:orders, on_delete: :delete_all), null: false
      add :product_id, references(:products, on_delete: :nilify_all)
      add :product_name, :string, null: false
      add :size, :string
      add :quantity, :integer, default: 1, null: false
      add :unit_price, :integer, null: false

      timestamps()
    end

    create index(:order_items, [:order_id])
    create index(:order_items, [:product_id])
  end
end
