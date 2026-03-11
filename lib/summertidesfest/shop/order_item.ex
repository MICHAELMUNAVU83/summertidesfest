defmodule Summertidesfest.Shop.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do
    field :product_name, :string
    field :size, :string
    field :quantity, :integer, default: 1
    field :unit_price, :integer

    belongs_to :order, Summertidesfest.Shop.Order
    belongs_to :product, Summertidesfest.Shop.Product

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:product_name, :size, :quantity, :unit_price, :order_id, :product_id])
    |> validate_required([:product_name, :quantity, :unit_price])
    |> validate_number(:quantity, greater_than: 0)
  end
end
