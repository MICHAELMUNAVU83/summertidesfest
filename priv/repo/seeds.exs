alias Summertidesfest.{Repo, Accounts, Shop}

# ---------------------------------------------------------------------------
# Admin user
# ---------------------------------------------------------------------------
email = "admin@summertidesfest.com"
password = "SummerLove2026!"

case Accounts.get_user_by_email(email) do
  nil ->
    {:ok, _user} = Accounts.register_user(%{email: email, password: password})
    IO.puts("✓ Admin user created: #{email}")
  _existing ->
    IO.puts("→ Admin user already exists: #{email}")
end

# ---------------------------------------------------------------------------
# Merch products — Unsplash images (free, no auth required)
# ---------------------------------------------------------------------------
products = [
  %{
    name: "Summer Love Classic Tee",
    description: "The iconic Summer Tides 2026 tee. 100% cotton, relaxed fit. Made for the beach, made for the crowd.",
    price: 2500,
    sizes: ["XS", "S", "M", "L", "XL", "XXL"],
    images: [
      "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1503341504253-dff4815485f1?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1562157873-818bc0726f68?w=800&fit=crop&q=80"
    ],
    category: "Tees",
    in_stock: true,
    stock_count: 100
  },
  %{
    name: "Summer Tides Wave Tee",
    description: "Limited edition wave-print tee. Ultra-soft fabric with a bold graphic on the back. Festival energy all year round.",
    price: 2500,
    sizes: ["S", "M", "L", "XL", "XXL"],
    images: [
      "https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1529374255404-311a2a4f1fd9?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=800&fit=crop&q=80"
    ],
    category: "Tees",
    in_stock: true,
    stock_count: 80
  },
  %{
    name: "Summer Tides Hoodie",
    description: "Premium heavyweight hoodie. Oversized fit, kangaroo pocket, embroidered Summer Tides logo. Perfect for those cool Malindi nights.",
    price: 4500,
    sizes: ["S", "M", "L", "XL", "XXL"],
    images: [
      "https://images.unsplash.com/photo-1556821840-3a63f15732ce?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1509942774463-acf339cf87d5?w=800&fit=crop&q=80"
    ],
    category: "Hoodies",
    in_stock: true,
    stock_count: 50
  },
  %{
    name: "Summer Love Bucket Hat",
    description: "Sun protection meets festival fashion. Reversible bucket hat with embroidered logo. One size fits all.",
    price: 1800,
    sizes: ["One Size"],
    images: [
      "https://images.unsplash.com/photo-1572307480813-ceb0e59d8325?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1514327605112-b887c0e61c0a?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1617952739647-a0de90b1d4df?w=800&fit=crop&q=80"
    ],
    category: "Hats",
    in_stock: true,
    stock_count: 60
  },
  %{
    name: "Summer Tides Cap",
    description: "Structured 6-panel cap with curved brim. Adjustable strap. Embroidered Summer Tides logo on front.",
    price: 1500,
    sizes: ["One Size"],
    images: [
      "https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1596643397885-e9f7c3ff8a72?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1556306535-0f09a537f0a3?w=800&fit=crop&q=80"
    ],
    category: "Hats",
    in_stock: true,
    stock_count: 75
  },
  %{
    name: "Festival Beach Towel",
    description: "XL microfibre beach towel with full Summer Tides 2026 graphic. Sand-resistant, quick-dry. Your festival essential.",
    price: 2200,
    sizes: ["One Size"],
    images: [
      "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1473116763249-2faaef81ccda?w=800&fit=crop&q=80"
    ],
    category: "Accessories",
    in_stock: true,
    stock_count: 40
  },
  %{
    name: "Summer Tides Tote Bag",
    description: "Heavy-duty canvas tote. Carry your festival gear in style. Printed Summer Tides artwork on natural canvas.",
    price: 1200,
    sizes: ["One Size"],
    images: [
      "https://images.unsplash.com/photo-1591561954557-26941169b49e?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1547949003-9792a18a2601?w=800&fit=crop&q=80"
    ],
    category: "Accessories",
    in_stock: true,
    stock_count: 90
  },
  %{
    name: "Summer Love Shorts",
    description: "Festival boardshorts in a lightweight, quick-dry fabric. All-over Summer Tides print. Made for the beach.",
    price: 3000,
    sizes: ["S", "M", "L", "XL", "XXL"],
    images: [
      "https://images.unsplash.com/photo-1591195853828-11db59a44f43?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1565084888279-aca607ecce0c?w=800&fit=crop&q=80",
      "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=800&fit=crop&q=80"
    ],
    category: "Bottoms",
    in_stock: true,
    stock_count: 35
  }
]

Enum.each(products, fn attrs ->
  case Repo.get_by(Summertidesfest.Shop.Product, name: attrs.name) do
    nil ->
      {:ok, _} = Shop.create_product(attrs)
      IO.puts("✓ Created: #{attrs.name}")
    existing ->
      {:ok, _} = Shop.update_product(existing, attrs)
      IO.puts("↺ Updated: #{attrs.name}")
  end
end)
