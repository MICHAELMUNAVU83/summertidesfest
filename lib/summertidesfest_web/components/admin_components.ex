defmodule SummertidesfestWeb.AdminComponents do
  use Phoenix.Component

  @doc """
  Renders the shared admin sidebar.
  Pass `active` as one of: "dashboard", "orders", "products".
  """
  attr :active, :string, default: ""
  attr :open, :boolean, default: false

  def sidebar(assigns) do
    ~H"""
    <%!-- Mobile backdrop --%>
    <%= if @open do %>
      <div
        class="lg:hidden fixed inset-0 z-20 bg-black/40 backdrop-blur-sm"
        phx-click="toggle_sidebar"
      ></div>
    <% end %>

    <aside class={[
      "fixed inset-y-0 left-0 z-30 flex flex-col w-60 bg-white border-r border-stone-200 transition-transform duration-200 lg:static lg:translate-x-0",
      if(@open, do: "translate-x-0", else: "-translate-x-full")
    ]}>
      <%!-- Brand --%>
      <div class="flex items-center gap-2.5 px-5 h-14 border-b border-stone-100 flex-shrink-0">
        <div class="w-8 h-8 rounded-lg bg-[#5C2D0A] flex items-center justify-center flex-shrink-0">
          <img src="/images/summertides.png" alt="" class="h-5 w-auto" />
        </div>
      <div class="min-w-0">
        <p class="bangers text-[#5C2D0A] text-base tracking-wider leading-none truncate">Summer Tides</p>
        <p class="mon text-stone-400 text-[10px] uppercase tracking-widest mt-0.5">Admin</p>
      </div>
      </div>

      <%!-- Nav --%>
      <nav class="flex-1 overflow-y-auto px-3 py-4 space-y-0.5">
        <p class="text-[10px] font-bold uppercase tracking-widest text-stone-400 px-3 pt-1 pb-2">Menu</p>

        <a href="/admin/dashboard" class={nav_class(@active == "dashboard")}>
          <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 5a1 1 0 011-1h4a1 1 0 011 1v4a1 1 0 01-1 1H5a1 1 0 01-1-1V5zm10 0a1 1 0 011-1h4a1 1 0 011 1v4a1 1 0 01-1 1h-4a1 1 0 01-1-1V5zM4 15a1 1 0 011-1h4a1 1 0 011 1v4a1 1 0 01-1 1H5a1 1 0 01-1-1v-4zm10 0a1 1 0 011-1h4a1 1 0 011 1v4a1 1 0 01-1 1h-4a1 1 0 01-1-1v-4z"/>
          </svg>
          Dashboard
        </a>

        <a href="/admin/orders" class={nav_class(@active == "orders")}>
          <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
          </svg>
          Orders
        </a>

        <a href="/admin/products" class={nav_class(@active == "products")}>
          <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
          </svg>
          Products
        </a>

        <a href="/merch" class={nav_class(false)}>
          <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
          </svg>
          View Shop
        </a>

        <div class="pt-4">
          <p class="text-[10px] font-bold uppercase tracking-widest text-stone-400 px-3 pb-2">Other</p>

          <a href="/" class="flex items-center gap-2.5 px-3 py-2 rounded-lg text-stone-400 hover:bg-stone-50 hover:text-stone-600 text-sm font-medium transition-colors">
            <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
            </svg>
            Festival Site
          </a>

          <.link
            href="/users/log_out"
            method="delete"
            class="flex items-center gap-2.5 px-3 py-2 rounded-lg text-stone-400 hover:bg-red-50 hover:text-red-500 text-sm font-medium transition-colors"
          >
            <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
            </svg>
            Sign Out
          </.link>
        </div>
      </nav>

      <div class="px-5 py-3 border-t border-stone-100 flex-shrink-0">
        <p class="text-stone-300 text-xs">© Summer Tides 2026</p>
      </div>
    </aside>
    """
  end

  defp nav_class(true),
    do: "flex items-center gap-2.5 px-3 py-2 rounded-lg bg-[#5C2D0A]/10 text-[#5C2D0A] text-sm font-semibold"

  defp nav_class(false),
    do: "flex items-center gap-2.5 px-3 py-2 rounded-lg text-stone-500 hover:bg-stone-50 hover:text-stone-800 text-sm font-medium transition-colors"
end
