defmodule Summertidesfest.Shop do
  import Ecto.Query
  alias Summertidesfest.Repo
  alias Summertidesfest.Shop.{Product, Order, OrderItem}

  # ---------------------------------------------------------------------------
  # Products
  # ---------------------------------------------------------------------------

  def list_products do
    Repo.all(from p in Product, order_by: [asc: p.category, asc: p.name])
  end

  def list_products_by_category(category) do
    Repo.all(from p in Product, where: p.category == ^category, order_by: [asc: p.name])
  end

  def get_product!(id), do: Repo.get!(Product, id)

  def create_product(attrs) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product), do: Repo.delete(product)

  def categories do
    Repo.all(from p in Product, select: p.category, distinct: true, order_by: p.category)
  end

  # ---------------------------------------------------------------------------
  # Orders
  # ---------------------------------------------------------------------------

  def list_orders do
    Repo.all(
      from o in Order,
        order_by: [desc: o.inserted_at],
        preload: [order_items: :product]
    )
  end

  def get_order!(id) do
    Repo.get!(Order, id) |> Repo.preload(order_items: :product)
  end

  def create_order(attrs, items) do
    reference = generate_reference()

    Repo.transaction(fn ->
      {:ok, order} =
        %Order{}
        |> Order.changeset(Map.put(attrs, "reference", reference))
        |> Repo.insert()

      for item <- items do
        %OrderItem{}
        |> OrderItem.changeset(Map.put(item, "order_id", order.id))
        |> Repo.insert!()
      end

      Repo.preload(order, order_items: :product)
    end)
  end

  def update_order_status(%Order{} = order, status) do
    order
    |> Order.changeset(%{status: status})
    |> Repo.update()
  end

  def orders_summary do
    total = Repo.aggregate(Order, :count, :id)
    pending = Repo.aggregate(from(o in Order, where: o.status == "pending"), :count, :id)
    revenue = Repo.aggregate(from(o in Order, where: o.status != "cancelled"), :sum, :total) || 0
    %{total: total, pending: pending, revenue: revenue}
  end

  defp generate_reference do
    "ST-" <> (:crypto.strong_rand_bytes(4) |> Base.encode16())
  end
end
