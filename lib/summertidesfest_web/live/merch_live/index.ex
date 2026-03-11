defmodule SummertidesfestWeb.MerchLive.Index do
  use SummertidesfestWeb, :live_view

  alias Summertidesfest.Shop

  @impl true
  def mount(_params, _session, socket) do
    products = Shop.list_products()

    {:ok,
     socket
     |> assign(:page_title, "Merch — Summer Tides 2026")
     |> assign(:products, products)
     |> assign(:filtered_products, products)
     |> assign(:categories, ["All" | Shop.categories()])
     |> assign(:active_category, "All")
     |> assign(:cart, %{})
     |> assign(:cart_open, false)
     |> assign(:selected_product, nil)
     |> assign(:checkout_open, false)
     |> assign(:order_complete, nil)
     |> assign(:checkout_form, %{"customer_name" => "", "customer_email" => "", "customer_phone" => ""})
     |> assign(:checkout_errors, %{})}
  end

  @impl true
  def handle_event("filter_category", %{"category" => category}, socket) do
    filtered =
      if category == "All" do
        socket.assigns.products
      else
        Enum.filter(socket.assigns.products, &(&1.category == category))
      end

    {:noreply,
     socket
     |> assign(:active_category, category)
     |> assign(:filtered_products, filtered)}
  end

  def handle_event("open_product", %{"id" => id}, socket) do
    product = Shop.get_product!(String.to_integer(id))
    {:noreply, assign(socket, :selected_product, product)}
  end

  def handle_event("close_product", _params, socket) do
    {:noreply, assign(socket, :selected_product, nil)}
  end

  def handle_event("add_to_cart", %{"product_id" => pid, "size" => size}, socket) do
    product = Shop.get_product!(String.to_integer(pid))
    cart = socket.assigns.cart
    key = "#{pid}:#{size}"

    updated_cart =
      Map.update(cart, key, %{product: product, size: size, qty: 1}, fn item ->
        %{item | qty: item.qty + 1}
      end)

    {:noreply,
     socket
     |> assign(:cart, updated_cart)
     |> assign(:cart_open, true)
     |> assign(:selected_product, nil)}
  end

  def handle_event("remove_from_cart", %{"key" => key}, socket) do
    {:noreply, assign(socket, :cart, Map.delete(socket.assigns.cart, key))}
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

    {:noreply, assign(socket, :cart, updated_cart)}
  end

  def handle_event("toggle_cart", _params, socket) do
    {:noreply, assign(socket, :cart_open, !socket.assigns.cart_open)}
  end

  def handle_event("open_checkout", _params, socket) do
    {:noreply, socket |> assign(:checkout_open, true) |> assign(:cart_open, false)}
  end

  def handle_event("close_checkout", _params, socket) do
    {:noreply, assign(socket, :checkout_open, false)}
  end

  def handle_event("update_checkout_field", %{"field" => field, "value" => value}, socket) do
    form = Map.put(socket.assigns.checkout_form, field, value)
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

      case Shop.create_order(attrs, items) do
        {:ok, order} ->
          {:noreply,
           socket
           |> assign(:order_complete, order)
           |> assign(:checkout_open, false)
           |> assign(:cart, %{})}

        {:error, _changeset} ->
          {:noreply, assign(socket, :checkout_errors, %{general: "Something went wrong. Please try again."})}
      end
    end
  end

  def handle_event("close_success", _params, socket) do
    {:noreply, assign(socket, :order_complete, nil)}
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
end
