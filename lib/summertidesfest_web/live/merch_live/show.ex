defmodule SummertidesfestWeb.MerchLive.Show do
  use SummertidesfestWeb, :live_view

  alias Summertidesfest.Shop
  alias Summertidesfest.Paystack

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    product = Shop.get_product!(String.to_integer(id))

    {:ok,
     socket
     |> assign(:page_title, "#{product.name} — Summer Tides Merch")
     |> assign(:product, product)
     |> assign(:selected_size, default_size(product))
     |> assign(:selected_image, 0)
     |> assign(:qty, 1)
     |> assign(:cart, %{})
     |> assign(:cart_open, false)
     |> assign(:checkout_open, false)
     |> assign(:checkout_form, %{"customer_name" => "", "customer_email" => "", "customer_phone" => ""})
     |> assign(:checkout_errors, %{})
     |> assign(:loading, false)}
  end

  # ── Product interactions ───────────────────────────────────────────────────

  @impl true
  def handle_event("select_size", %{"size" => size}, socket) do
    {:noreply, assign(socket, :selected_size, size)}
  end

  def handle_event("select_image", %{"index" => idx}, socket) do
    {:noreply, assign(socket, :selected_image, String.to_integer(idx))}
  end

  def handle_event("set_qty", %{"delta" => delta}, socket) do
    new_qty = max(1, socket.assigns.qty + String.to_integer(delta))
    {:noreply, assign(socket, :qty, new_qty)}
  end

  # ── Cart ───────────────────────────────────────────────────────────────────

  def handle_event("add_to_cart", _params, socket) do
    %{product: product, selected_size: size, qty: qty, cart: cart} = socket.assigns
    key = "#{product.id}:#{size}"

    updated_cart =
      Map.update(cart, key, %{product: product, size: size, qty: qty}, fn item ->
        %{item | qty: item.qty + qty}
      end)

    {:noreply,
     socket
     |> assign(:cart, updated_cart)
     |> assign(:cart_open, true)
     |> assign(:qty, 1)
     |> push_event("save_merch_cart", %{cart: serialize_cart(updated_cart)})}
  end

  def handle_event("remove_from_cart", %{"key" => key}, socket) do
    updated_cart = Map.delete(socket.assigns.cart, key)

    {:noreply,
     socket
     |> assign(:cart, updated_cart)
     |> push_event("save_merch_cart", %{cart: serialize_cart(updated_cart)})}
  end

  def handle_event("update_qty", %{"key" => key, "delta" => delta}, socket) do
    delta = String.to_integer(delta)
    cart = socket.assigns.cart

    updated_cart =
      Map.update(cart, key, %{}, fn item ->
        new_qty = item.qty + delta
        if new_qty <= 0, do: nil, else: %{item | qty: new_qty}
      end)
      |> Enum.reject(fn {_k, v} -> is_nil(v) end)
      |> Map.new()

    {:noreply,
     socket
     |> assign(:cart, updated_cart)
     |> push_event("save_merch_cart", %{cart: serialize_cart(updated_cart)})}
  end

  def handle_event("toggle_cart", _params, socket) do
    {:noreply, assign(socket, :cart_open, !socket.assigns.cart_open)}
  end

  def handle_event("close_cart", _params, socket) do
    {:noreply, assign(socket, :cart_open, false)}
  end

  def handle_event("restore_cart", %{"cart" => items}, socket) do
    cart =
      Enum.reduce(items, %{}, fn item, acc ->
        try do
          product = Shop.get_product!(item["product_id"])
          key = "#{item["product_id"]}:#{item["size"]}"
          Map.put(acc, key, %{product: product, size: item["size"], qty: item["qty"]})
        rescue
          _ -> acc
        end
      end)

    {:noreply, assign(socket, :cart, cart)}
  end

  # ── Checkout ──────────────────────────────────────────────────────────────

  def handle_event("open_checkout", _params, socket) do
    {:noreply, socket |> assign(:checkout_open, true) |> assign(:cart_open, false)}
  end

  def handle_event("close_checkout", _params, socket) do
    {:noreply, assign(socket, :checkout_open, false)}
  end

  def handle_event("update_checkout_field", params, socket) do
    form =
      socket.assigns.checkout_form
      |> Map.merge(Map.take(params, ["customer_name", "customer_email", "customer_phone"]))

    {:noreply, assign(socket, :checkout_form, form)}
  end

  def handle_event("submit_order", _params, socket) do
    form = socket.assigns.checkout_form
    cart = socket.assigns.cart
    errors = validate_checkout(form)

    if map_size(errors) > 0 do
      {:noreply, assign(socket, :checkout_errors, errors)}
    else
      total = cart_total(cart)

      items =
        Enum.map(cart, fn {_key, item} ->
          %{
            "product_id" => item.product.id,
            "product_name" => item.product.name,
            "size" => item.size,
            "quantity" => item.qty,
            "unit_price" => item.product.price
          }
        end)

      attrs = Map.put(form, "total", total)

      socket = assign(socket, :loading, true)

      case Shop.create_order(attrs, items) do
        {:ok, order} ->
          case Paystack.initialize(form["customer_email"], total, order.reference) do
            {:ok, %{authorization_url: url}} ->
              {:noreply,
               socket
               |> push_event("clear_merch_cart", %{})
               |> push_event("redirect_to", %{url: url})}

            {:error, reason} ->
              {:noreply,
               socket
               |> assign(:loading, false)
               |> assign(:checkout_errors, %{general: "Payment failed: #{reason}"})}
          end

        {:error, _changeset} ->
          {:noreply,
           socket
           |> assign(:loading, false)
           |> assign(:checkout_errors, %{general: "Something went wrong. Please try again."})}
      end
    end
  end

  # ── Helpers ───────────────────────────────────────────────────────────────

  defp serialize_cart(cart) do
    Enum.map(cart, fn {key, item} ->
      image = if length(item.product.images) > 0, do: hd(item.product.images), else: nil

      %{
        key: key,
        product_id: item.product.id,
        name: item.product.name,
        size: item.size,
        qty: item.qty,
        price: item.product.price,
        image: image,
        category: item.product.category
      }
    end)
  end

  def cart_total(cart) do
    Enum.reduce(cart, 0, fn {_k, item}, acc -> acc + item.product.price * item.qty end)
  end

  def cart_count(cart) do
    Enum.reduce(cart, 0, fn {_k, item}, acc -> acc + item.qty end)
  end

  def format_price(ksh) when is_integer(ksh) do
    formatted =
      ksh
      |> Integer.to_string()
      |> String.reverse()
      |> String.graphemes()
      |> Enum.chunk_every(3)
      |> Enum.join(",")
      |> String.reverse()

    "KSH #{formatted}"
  end

  defp validate_checkout(form) do
    errors = %{}
    errors = if form["customer_name"] == "", do: Map.put(errors, "customer_name", "Name is required"), else: errors
    errors = if form["customer_email"] == "", do: Map.put(errors, "customer_email", "Email is required"), else: errors

    errors =
      if form["customer_email"] != "" and not String.match?(form["customer_email"], ~r/^[^\s]+@[^\s]+$/) do
        Map.put(errors, "customer_email", "Enter a valid email")
      else
        errors
      end

    errors
  end

  defp default_size(%{sizes: [first | _]}), do: first
  defp default_size(_), do: "One Size"
end
