defmodule SummertidesfestWeb.HomeLive.Index do
  use SummertidesfestWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.home_header />
    <.home_hero />
    <.home_gallery />
    <.home_about />
    <.home_rewind_time />
    <.home_supported_by />
    <.home_footer />
    """
  end
end
