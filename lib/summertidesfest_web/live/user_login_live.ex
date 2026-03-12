defmodule SummertidesfestWeb.UserLoginLive do
  use SummertidesfestWeb, :live_view

  def render(assigns) do
    ~H"""
    <div
      class="min-h-screen flex items-center justify-center px-4 relative"
      style="background-color: #0D0800;"
    >
      <%!-- Subtle bg image overlay --%>
      <div
        class="absolute inset-0 bg-cover bg-center opacity-10 pointer-events-none"
        style="background-image: url('/images/pic5.jpg');"
      ></div>
      <div class="absolute inset-0 pointer-events-none" style="background: linear-gradient(to bottom, #0D0800 0%, transparent 40%, #0D0800 100%);"></div>

      <div class="relative z-10 w-full max-w-sm">

        <%!-- Logo + branding --%>
        <div class="text-center mb-8">
          <img src="/images/summertides.png" class="w-24 mx-auto mb-4 object-contain" />
          <h1 class="bangers text-[#E8C87A] text-5xl tracking-widest uppercase leading-none">
            Summer Tides
          </h1>
          <p class="text-white/30 mon text-xs uppercase tracking-[0.3em] mt-2">
            Admin Portal
          </p>
        </div>

        <%!-- Login card --%>
        <div class="border border-[#5C2D0A] px-8 py-10" style="background-color: rgba(13, 8, 0, 0.95);">
          <h2 class="bangers text-white text-2xl tracking-widest uppercase text-center mb-8">
            Sign In
          </h2>

          <.form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
            <div class="flex flex-col gap-5">

              <%!-- Email field --%>
              <div class="flex flex-col gap-2">
                <label class="text-[#E8C87A] text-xs uppercase tracking-widest mon font-semibold">
                  Email
                </label>
                <input
                  type="email"
                  name="user[email]"
                  value={@form[:email].value || ""}
                  required
                  autocomplete="email"
                  class="bg-transparent border border-[#5C2D0A] focus:border-[#E8C87A] text-white px-4 py-3 mon text-sm outline-none transition-colors duration-200 w-full placeholder-white/20"
                  placeholder="your@email.com"
                />
              </div>

              <%!-- Password field --%>
              <div class="flex flex-col gap-2">
                <label class="text-[#E8C87A] text-xs uppercase tracking-widest mon font-semibold">
                  Password
                </label>
                <input
                  type="password"
                  name="user[password]"
                  required
                  autocomplete="current-password"
                  class="bg-transparent border border-[#5C2D0A] focus:border-[#E8C87A] text-white px-4 py-3 mon text-sm outline-none transition-colors duration-200 w-full placeholder-white/20"
                  placeholder="••••••••••••"
                />
              </div>

              <%!-- Remember me --%>
              <div class="flex items-center gap-3">
                <input
                  type="checkbox"
                  name="user[remember_me]"
                  id="remember_me"
                  class="w-4 h-4 accent-[#E8C87A] cursor-pointer"
                />
                <label for="remember_me" class="text-white/40 mon text-xs uppercase tracking-wider cursor-pointer select-none">
                  Keep me logged in
                </label>
              </div>

              <%!-- Submit button --%>
              <button
                type="submit"
                class="w-full mt-2 bg-[#5C2D0A] hover:bg-[#E8C87A] hover:text-[#5C2D0A] text-[#E8C87A] font-bold uppercase tracking-widest py-3 bangers text-xl transition-all duration-300"
              >
                Sign In →
              </button>

            </div>
          </.form>
        </div>

        <p class="text-center text-white/20 mon text-xs mt-8 uppercase tracking-widest">
          © 2026 Summer Tides · Airbeat Global
        </p>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
