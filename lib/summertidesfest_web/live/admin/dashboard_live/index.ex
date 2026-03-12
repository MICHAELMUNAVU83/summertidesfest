defmodule SummertidesfestWeb.Admin.DashboardLive.Index do
  use SummertidesfestWeb, :live_view

  alias Summertidesfest.Shop

  @impl true
  def mount(_params, _session, socket) do
    summary = Shop.orders_summary()
    recent_orders = Shop.list_orders() |> Enum.take(5)
    products_count = Shop.list_products() |> length()
    revenue_data = Shop.revenue_last_days(7)
    status_data = Shop.orders_by_status()

    revenue_chart =
      revenue_data
      |> Enum.map(fn {date, total} ->
        %{label: Calendar.strftime(date, "%b %d"), value: total || 0}
      end)

    status_chart =
      status_data
      |> Enum.map(fn {status, count} -> %{label: status, value: count} end)

    {:ok,
     socket
     |> assign(:page_title, "Dashboard — Summer Tides Admin")
     |> assign(:summary, summary)
     |> assign(:recent_orders, recent_orders)
     |> assign(:products_count, products_count)
     |> assign(:revenue_chart, revenue_chart)
     |> assign(:status_chart, status_chart)
     |> assign(:sidebar_open, false)}
  end

  @impl true
  def handle_event("toggle_sidebar", _params, socket) do
    {:noreply, assign(socket, :sidebar_open, !socket.assigns.sidebar_open)}
  end

  def handle_event("charts_mounted", _params, socket) do
    {:noreply,
     push_event(socket, "render_charts", %{
       revenue: socket.assigns.revenue_chart,
       statuses: socket.assigns.status_chart
     })}
  end

  def status_badge("pending"),    do: "bg-amber-50 text-amber-700 border border-amber-200"
  def status_badge("processing"), do: "bg-blue-50 text-blue-700 border border-blue-200"
  def status_badge("shipped"),    do: "bg-violet-50 text-violet-700 border border-violet-200"
  def status_badge("delivered"),  do: "bg-emerald-50 text-emerald-700 border border-emerald-200"
  def status_badge("cancelled"),  do: "bg-red-50 text-red-600 border border-red-200"
  def status_badge(_),            do: "bg-stone-100 text-stone-500 border border-stone-200"

  def format_date(dt), do: Calendar.strftime(dt, "%b %d · %H:%M")
end
