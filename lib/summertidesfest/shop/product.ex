defmodule Summertidesfest.Shop.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string
    field :price, :integer
    field :sizes, {:array, :string}, default: []
    field :images, {:array, :string}, default: []
    field :category, :string
    field :in_stock, :boolean, default: true
    field :stock_count, :integer, default: 0

    has_many :order_items, Summertidesfest.Shop.OrderItem

    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price, :sizes, :images, :category, :in_stock, :stock_count])
    |> validate_required([:name, :price, :category])
    |> validate_number(:price, greater_than: 0)
  end
end
