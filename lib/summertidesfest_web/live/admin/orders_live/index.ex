defmodule SummertidesfestWeb.Admin.OrdersLive.Index do
  use SummertidesfestWeb, :live_view

  alias Summertidesfest.Shop

  @impl true
  def mount(_params, _session, socket) do
    orders = Shop.list_orders()
    summary = Shop.orders_summary()

    {:ok,
     socket
     |> assign(:page_title, "Orders — Summer Tides Admin")
     |> assign(:orders, orders)
     |> assign(:summary, summary)
     |> assign(:selected_order, nil)
     |> assign(:filter_status, "all")
     |> assign(:sidebar_open, false)}
  end

  @impl true
  def handle_event("toggle_sidebar", _params, socket) do
    {:noreply, assign(socket, :sidebar_open, !socket.assigns.sidebar_open)}
  end

  def handle_event("filter_status", %{"status" => status}, socket) do
    {:noreply, assign(socket, :filter_status, status)}
  end

  def handle_event("view_order", %{"id" => id}, socket) do
    order = Shop.get_order!(String.to_integer(id))
    {:noreply, assign(socket, :selected_order, order)}
  end

  def handle_event("close_order", _params, socket) do
    {:noreply, assign(socket, :selected_order, nil)}
  end

  def handle_event("update_status", %{"id" => id, "status" => status}, socket) do
    order = Shop.get_order!(String.to_integer(id))

    case Shop.update_order_status(order, status) do
      {:ok, _updated} ->
        orders = Shop.list_orders()
        summary = Shop.orders_summary()
        selected = if socket.assigns.selected_order && socket.assigns.selected_order.id == order.id do
          Shop.get_order!(order.id)
        else
          socket.assigns.selected_order
        end

        {:noreply,
         socket
         |> assign(:orders, orders)
         |> assign(:summary, summary)
         |> assign(:selected_order, selected)
         |> put_flash(:info, "Order status updated to #{status}")}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Failed to update order status")}
    end
  end

  def filtered_orders(orders, "all"), do: orders
  def filtered_orders(orders, status), do: Enum.filter(orders, &(&1.status == status))

  def status_badge("pending"),    do: "bg-amber-50 text-amber-700 border border-amber-200"
  def status_badge("processing"), do: "bg-blue-50 text-blue-700 border border-blue-200"
  def status_badge("shipped"),    do: "bg-violet-50 text-violet-700 border border-violet-200"
  def status_badge("delivered"),  do: "bg-emerald-50 text-emerald-700 border border-emerald-200"
  def status_badge("cancelled"),  do: "bg-red-50 text-red-600 border border-red-200"
  def status_badge(_),            do: "bg-stone-100 text-stone-500 border border-stone-200"

  # keep old name as alias for any remaining callers
  def status_color(s), do: status_badge(s)

  def format_date(dt) do
    Calendar.strftime(dt, "%b %d, %Y · %H:%M")
  end
end
