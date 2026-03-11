defmodule Summertidesfest.Shop.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @statuses ~w(pending processing shipped delivered cancelled)

  schema "orders" do
    field :customer_name, :string
    field :customer_email, :string
    field :customer_phone, :string
    field :total, :integer
    field :status, :string, default: "pending"
    field :notes, :string
    field :reference, :string

    has_many :order_items, Summertidesfest.Shop.OrderItem

    timestamps()
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, [:customer_name, :customer_email, :customer_phone, :total, :status, :notes, :reference])
    |> validate_required([:customer_name, :customer_email, :total])
    |> validate_format(:customer_email, ~r/^[^\s]+@[^\s]+$/)
    |> validate_inclusion(:status, @statuses)
    |> unique_constraint(:reference)
  end

  def statuses, do: @statuses
end
