alias Summertidesfest.{Repo, Accounts, Shop}

# Seed admin user
email = "admin@summertidesfest.com"
password = "SummerLove2026!"

case Accounts.get_user_by_email(email) do
  nil ->
    {:ok, _user} =
      Accounts.register_user(%{
        email: email,
        password: password
      })

    IO.puts("✓ Admin user created: #{email}")

  _existing ->
    IO.puts("→ Admin user already exists: #{email}")
end

# ---------------------------------------------------------------------------
# Seed merch products
# ---------------------------------------------------------------------------
products = [
  %{
    name: "Summer Love Classic Tee",
    description: "The iconic Summer Tides 2026 tee. 100% cotton, relaxed fit. Made for the beach, made for the crowd.",
    price: 2500,
    sizes: ["XS", "S", "M", "L", "XL", "XXL"],
    images: ["/images/summertides.png"],
    category: "Tees",
    in_stock: true,
    stock_count: 100
  },
  %{
    name: "Summer Tides Wave Tee",
    description: "Limited edition wave-print tee. Ultra-soft fabric with a bold graphic on the back. Festival energy all year round.",
    price: 2500,
    sizes: ["S", "M", "L", "XL", "XXL"],
    images: ["/images/summertides.png"],
    category: "Tees",
    in_stock: true,
    stock_count: 80
  },
  %{
    name: "Summer Tides Hoodie",
    description: "Premium heavyweight hoodie. Oversized fit, kangaroo pocket, embroidered Summer Tides logo. Perfect for those cool Malindi nights.",
    price: 4500,
    sizes: ["S", "M", "L", "XL", "XXL"],
    images: ["/images/summertides.png"],
    category: "Hoodies",
    in_stock: true,
    stock_count: 50
  },
  %{
    name: "Summer Love Bucket Hat",
    description: "Sun protection meets festival fashion. Reversible bucket hat with embroidered logo. One size fits all.",
    price: 1800,
    sizes: ["One Size"],
    images: ["/images/summertides.png"],
    category: "Hats",
    in_stock: true,
    stock_count: 60
  },
  %{
    name: "Summer Tides Cap",
    description: "Structured 6-panel cap with curved brim. Adjustable strap. Embroidered Summer Tides logo on front.",
    price: 1500,
    sizes: ["One Size"],
    images: ["/images/summertides.png"],
    category: "Hats",
    in_stock: true,
    stock_count: 75
  },
  %{
    name: "Festival Beach Towel",
    description: "XL microfibre beach towel with full Summer Tides 2026 graphic. Sand-resistant, quick-dry. Your festival essential.",
    price: 2200,
    sizes: ["One Size"],
    images: ["/images/summertides.png"],
    category: "Accessories",
    in_stock: true,
    stock_count: 40
  },
  %{
    name: "Summer Tides Tote Bag",
    description: "Heavy-duty canvas tote. Carry your festival gear in style. Printed Summer Tides artwork.",
    price: 1200,
    sizes: ["One Size"],
    images: ["/images/summertides.png"],
    category: "Accessories",
    in_stock: true,
    stock_count: 90
  },
  %{
    name: "Summer Love Shorts",
    description: "Festival boardshorts in a lightweight, quick-dry fabric. All-over Summer Tides print. Made for the beach.",
    price: 3000,
    sizes: ["S", "M", "L", "XL", "XXL"],
    images: ["/images/summertides.png"],
    category: "Bottoms",
    in_stock: true,
    stock_count: 35
  }
]

Enum.each(products, fn attrs ->
  case Repo.get_by(Summertidesfest.Shop.Product, name: attrs.name) do
    nil ->
      {:ok, _} = Shop.create_product(attrs)
      IO.puts("✓ Product created: #{attrs.name}")
    _ ->
      IO.puts("→ Product already exists: #{attrs.name}")
  end
end)
