import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import Chart from "chart.js/auto"

// Navbar scroll hook
let NavBar = {
  mounted() {
    this.handleScroll = () => {
      if (window.scrollY >= 100) {
        this.el.style.backgroundColor = "black"
      } else {
        this.el.style.backgroundColor = "transparent"
      }
    }
    window.addEventListener("scroll", this.handleScroll)
  },
  destroyed() {
    window.removeEventListener("scroll", this.handleScroll)
  }
}

// Mobile nav toggle hook
let MobileNav = {
  mounted() {
    this.el.addEventListener("click", () => {
      const menu = document.getElementById("mobile-menu")
      const icon = document.getElementById("nav-icon")
      if (menu.classList.contains("left-[-100%]")) {
        menu.classList.remove("left-[-100%]")
        menu.classList.add("left-0")
        icon.dataset.open = "true"
      } else {
        menu.classList.remove("left-0")
        menu.classList.add("left-[-100%]")
        icon.dataset.open = "false"
      }
    })
  }
}

let CloseMobileNav = {
  mounted() {
    this.el.addEventListener("click", () => {
      const menu = document.getElementById("mobile-menu")
      menu.classList.remove("left-0")
      menu.classList.add("left-[-100%]")
    })
  }
}

// Hero slideshow hook
let HeroSlider = {
  mounted() {
    const slides = this.el.querySelectorAll(".hero-slide")
    let current = 0
    slides[current].classList.add("active")

    this.interval = setInterval(() => {
      slides[current].classList.remove("active")
      current = (current + 1) % slides.length
      slides[current].classList.add("active")
    }, 3000)
  },
  destroyed() {
    clearInterval(this.interval)
  }
}

// Countdown hook
let CountDown = {
  mounted() {
    const countDownDate = new Date("Jul 2, 2026 14:00:00").getTime()

    this.interval = setInterval(() => {
      const now = new Date().getTime()
      const distance = countDownDate - now

      if (distance < 0) {
        clearInterval(this.interval)
        const daysEl = this.el.querySelector("#days")
        const hoursEl = this.el.querySelector("#hours")
        const minutesEl = this.el.querySelector("#minutes")
        const secondsEl = this.el.querySelector("#seconds")
        if (daysEl) daysEl.innerHTML = "0"
        if (hoursEl) hoursEl.innerHTML = "0"
        if (minutesEl) minutesEl.innerHTML = "0"
        if (secondsEl) secondsEl.innerHTML = "0"
        return
      }

      const days = Math.floor(distance / (1000 * 60 * 60 * 24))
      const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
      const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))
      const seconds = Math.floor((distance % (1000 * 60)) / 1000)

      const daysEl = this.el.querySelector("#days")
      const hoursEl = this.el.querySelector("#hours")
      const minutesEl = this.el.querySelector("#minutes")
      const secondsEl = this.el.querySelector("#seconds")

      if (daysEl) daysEl.innerHTML = days
      if (hoursEl) hoursEl.innerHTML = hours
      if (minutesEl) minutesEl.innerHTML = minutes
      if (secondsEl) secondsEl.innerHTML = seconds
    }, 1000)
  },
  destroyed() {
    clearInterval(this.interval)
  }
}

// Gallery hook (no-op — layout is now a static masonry grid)
let Gallery = {
  mounted() {},
  destroyed() {}
}

// Cart — home page merch section
let Cart = {
  mounted() {
    try {
      const saved = localStorage.getItem("st_cart")
      if (saved) {
        const items = JSON.parse(saved)
        if (Array.isArray(items) && items.length > 0) {
          this.pushEvent("restore_cart", { cart: items })
        }
      }
    } catch (e) {}

    this.handleEvent("save_cart", ({ cart }) => {
      try { localStorage.setItem("st_cart", JSON.stringify(cart)) } catch (e) {}
    })
  }
}

// Admin charts via Chart.js
let AdminCharts = {
  mounted() {
    this.charts = {}

    this.handleEvent("render_charts", ({ revenue, statuses }) => {
      this.renderRevenueChart(revenue)
      this.renderStatusChart(statuses)
    })
  },

  renderRevenueChart(data) {
    const el = document.getElementById("revenue-chart")
    if (!el) return
    if (this.charts.revenue) this.charts.revenue.destroy()

    this.charts.revenue = new Chart(el, {
      type: "line",
      data: {
        labels: data.map(d => d.label),
        datasets: [{
          label: "Revenue (KSH)",
          data: data.map(d => d.value),
          borderColor: "#5C2D0A",
          backgroundColor: "rgba(92,45,10,0.08)",
          borderWidth: 2.5,
          pointBackgroundColor: "#5C2D0A",
          pointRadius: 4,
          tension: 0.4,
          fill: true
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: {
          y: {
            beginAtZero: true,
            grid: { color: "rgba(0,0,0,0.04)" },
            ticks: { color: "#78716c", font: { size: 11 } }
          },
          x: {
            grid: { display: false },
            ticks: { color: "#78716c", font: { size: 11 } }
          }
        }
      }
    })
  },

  renderStatusChart(data) {
    const el = document.getElementById("status-chart")
    if (!el) return
    if (this.charts.status) this.charts.status.destroy()

    const colors = {
      pending:    "#f59e0b",
      processing: "#3b82f6",
      shipped:    "#8b5cf6",
      delivered:  "#10b981",
      cancelled:  "#ef4444"
    }

    this.charts.status = new Chart(el, {
      type: "doughnut",
      data: {
        labels: data.map(d => d.label),
        datasets: [{
          data: data.map(d => d.value),
          backgroundColor: data.map(d => colors[d.label] || "#a8a29e"),
          borderWidth: 0,
          hoverOffset: 6
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: "72%",
        plugins: {
          legend: {
            position: "bottom",
            labels: { color: "#78716c", font: { size: 11 }, padding: 14, boxWidth: 10 }
          }
        }
      }
    })
  },

  destroyed() {
    Object.values(this.charts).forEach(c => c.destroy())
  }
}

// MerchCart — shared cart across /merch and /merch/:id pages
const MERCH_CART_KEY = "st_merch_cart"

let MerchCart = {
  mounted() {
    // Restore cart from localStorage on page load
    try {
      const saved = localStorage.getItem(MERCH_CART_KEY)
      if (saved) {
        const items = JSON.parse(saved)
        if (Array.isArray(items) && items.length > 0) {
          this.pushEvent("restore_cart", { cart: items })
        }
      }
    } catch (e) {}

    // Save cart whenever LiveView updates it
    this.handleEvent("save_merch_cart", ({ cart }) => {
      try { localStorage.setItem(MERCH_CART_KEY, JSON.stringify(cart)) } catch (e) {}
    })

    // Clear cart on successful order
    this.handleEvent("clear_merch_cart", () => {
      try { localStorage.removeItem(MERCH_CART_KEY) } catch (e) {}
    })

    // Redirect to Paystack (more reliable than LiveView external redirect)
    this.handleEvent("redirect_to", ({ url }) => {
      window.location.href = url
    })
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: { NavBar, MobileNav, CloseMobileNav, HeroSlider, CountDown, Gallery, Cart, MerchCart, AdminCharts }
})

topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

liveSocket.connect()
window.liveSocket = liveSocket
