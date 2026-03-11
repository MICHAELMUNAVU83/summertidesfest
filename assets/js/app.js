import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

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

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: { NavBar, MobileNav, CloseMobileNav, HeroSlider, CountDown, Gallery }
})

topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

liveSocket.connect()
window.liveSocket = liveSocket
