defmodule SummertidesfestWeb.HomeLive.Index do
  use SummertidesfestWeb, :live_view

  alias Summertidesfest.Shop

  @artists [
    %{name: "Grauchi", image: "/artists/GRAUCHI.jpeg"},
    %{name: "Sir M", image: "/artists/sirm.jpg"},
    %{name: "Etana", image: "/artists/etana.jpg"},
    %{name: "Joe Mfalme", image: "/artists/JOE MFALME.jpeg"},
    %{name: "G Money", image: "/artists/G MONEY.jpeg"},
    %{name: "Kaneda", image: "/artists/KANEDA.jpeg"},
    %{name: "Mista C", image: "/artists/mista.jpg"},
    %{name: "MC Gogo", image: "/artists/gogo.jpg"},
    %{name: "Dj Daffy", image: "/artists/daffy.jpg"},
    %{name: "Chipi", image: "/artists/chipi.jpg"},
    %{name: "Andy Young", image: "/artists/andyyoung.jpg"},
    %{name: "DJ Kace", image: "/artists/kace.jpg"},
    %{name: "Vansss", image: "/artists/vansss.jpg"},
    %{name: "KU5", image: "/artists/KU5.jpeg"},
    %{name: "Suraj", image: "/artists/SURAJ.jpeg"},
    %{name: "Ballo", image: "/artists/BALLO.jpg"},
    %{name: "Malonza", image: "/artists/MALONZA.jpeg"},
    %{name: "Ms Bune", image: "/artists/MS BUNE.jpeg"},
    %{name: "Euggy", image: "/artists/EUGGY.jpeg"},
    %{name: "Junior Petes", image: "/artists/JUNIOR PETES.jpeg"},
    %{name: "Santa", image: "/artists/SANTA.jpeg"},
    %{name: "Teekay", image: "/artists/TEEKAY.jpeg"},
    %{name: "Ms Mike", image: "/artists/MS MIKA.jpeg"},
    %{name: "TM", image: "/artists/TM.jpeg"}
  ]

  @gallery_images [
    "/images/pic.jpg",
    "/images/pic2.jpg",
    "/images/pic4.jpg",
    "/images/pic5.jpg",
    "/images/pic6.jpg",
    "/images/pic7.jpg",
    "/images/pic9.jpg"
  ]

  @hero_slides [
    "/images/pic.jpg",
    "/images/pic2.jpg",
    "/images/pic5.jpg",
    "/images/pic6.jpg",
    "/images/pic7.jpg"
  ]

  @schedule %{
    "day1" => [%{name: "TBA"}],
    "day2" => [%{name: "TBA"}],
    "day3" => [%{name: "TBA"}]
  }

  @impl true
  def mount(_params, _session, socket) do
    products = Shop.list_products()

    {:ok,
     socket
     |> assign(:page_title, "Summer Tides: Summer Love — July 2–4, 2026 | Lost Beach Club, Malindi")
     |> assign(:artists, @artists)
     |> assign(:gallery_images, @gallery_images)
     |> assign(:hero_slides, @hero_slides)
     |> assign(:schedule, @schedule)
     |> assign(:selected_day, "day1")
     |> assign(:products, products)
     |> assign(:merch_category, "All")
     |> assign(:selected_product, nil)
     |> assign(:selected_size, nil)
     |> assign(:cart, %{})
     |> assign(:cart_open, false)}
  end

  @impl true
  def handle_event("select_day", %{"day" => day}, socket) do
    {:noreply, assign(socket, :selected_day, day)}
  end

  # ---- Merch ----

  def handle_event("set_merch_category", %{"category" => cat}, socket) do
    {:noreply, assign(socket, :merch_category, cat)}
  end

  def handle_event("open_product", %{"id" => id}, socket) do
    product = Shop.get_product!(String.to_integer(id))
    first_size = List.first(product.sizes)
    {:noreply, socket |> assign(:selected_product, product) |> assign(:selected_size, first_size)}
  end

  def handle_event("close_product", _params, socket) do
    {:noreply, assign(socket, :selected_product, nil)}
  end

  def handle_event("select_size", %{"size" => size}, socket) do
    {:noreply, assign(socket, :selected_size, size)}
  end

  def handle_event("add_to_cart", %{"product_id" => pid, "size" => size}, socket) do
    product = Shop.get_product!(String.to_integer(pid))
    key = "#{pid}:#{size}"
    cart = Map.update(socket.assigns.cart, key,
      %{id: product.id, name: product.name, image: List.first(product.images), price: product.price, size: size, qty: 1},
      fn item -> %{item | qty: item.qty + 1} end
    )

    {:noreply,
     socket
     |> assign(:cart, cart)
     |> assign(:selected_product, nil)
     |> assign(:cart_open, true)
     |> push_event("save_cart", %{cart: serialize_cart(cart)})}
  end

  def handle_event("remove_from_cart", %{"key" => key}, socket) do
    cart = Map.delete(socket.assigns.cart, key)
    {:noreply,
     socket
     |> assign(:cart, cart)
     |> push_event("save_cart", %{cart: serialize_cart(cart)})}
  end

  def handle_event("update_qty", %{"key" => key, "delta" => delta}, socket) do
    delta = String.to_integer(delta)
    cart =
      socket.assigns.cart
      |> Map.update(key, %{}, fn item -> %{item | qty: item.qty + delta} end)
      |> Enum.reject(fn {_k, v} -> v.qty <= 0 end)
      |> Map.new()

    {:noreply,
     socket
     |> assign(:cart, cart)
     |> push_event("save_cart", %{cart: serialize_cart(cart)})}
  end

  def handle_event("toggle_cart", _params, socket) do
    {:noreply, assign(socket, :cart_open, !socket.assigns.cart_open)}
  end

  def handle_event("close_cart", _params, socket) do
    {:noreply, assign(socket, :cart_open, false)}
  end

  # Restore cart from localStorage on page load
  def handle_event("restore_cart", %{"cart" => items}, socket) when is_list(items) do
    cart =
      Enum.reduce(items, %{}, fn item, acc ->
        key = "#{item["id"]}:#{item["size"]}"
        Map.put(acc, key, %{
          id: item["id"],
          name: item["name"],
          image: item["image"],
          price: item["price"],
          size: item["size"],
          qty: item["qty"]
        })
      end)
    {:noreply, assign(socket, :cart, cart)}
  end

  def handle_event("restore_cart", _params, socket), do: {:noreply, socket}

  # ---- Helpers ----

  def cart_count(cart), do: Enum.reduce(cart, 0, fn {_, v}, acc -> acc + v.qty end)
  def cart_total(cart), do: Enum.reduce(cart, 0, fn {_, v}, acc -> acc + v.price * v.qty end)

  def filtered_products(products, "All"), do: products
  def filtered_products(products, cat), do: Enum.filter(products, &(&1.category == cat))

  defp serialize_cart(cart) do
    Enum.map(cart, fn {_key, item} ->
      %{id: item.id, name: item.name, image: item.image,
        price: item.price, size: item.size, qty: item.qty}
    end)
  end
end
