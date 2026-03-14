import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
// Chart.js is loaded via CDN in root.html.heex — available globally as window.Chart

// crypto.randomUUID polyfill — required by Phoenix LiveView on HTTP (non-secure) contexts.
// Browsers only expose crypto.randomUUID on localhost or HTTPS. This fallback ensures
// LiveView works when accessed over plain HTTP (e.g. a bare IP address in staging/prod).
if (typeof crypto.randomUUID !== "function") {
  crypto.randomUUID = function () {
    return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, c =>
      (c ^ (crypto.getRandomValues(new Uint8Array(1))[0] & (15 >> (c / 4)))).toString(16)
    )
  }
}

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

// Gallery3D — Three.js floating particles background + 3D tilt + lightbox
let Gallery3D = {
  mounted() {
    this._items = []
    this._destroyed = false
    this.setupParticles()
    this.setupTilt()
    this.setupLightbox()
    this.setupEntrance()
  },

  setupParticles() {
    if (typeof THREE === 'undefined') return
    const el = this.el
    const w = el.offsetWidth || window.innerWidth
    const h = Math.min(el.offsetHeight || 600, 900)

    const scene = new THREE.Scene()
    const camera = new THREE.PerspectiveCamera(60, w / h, 0.1, 100)
    camera.position.z = 4

    const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true })
    renderer.setSize(w, h)
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
    Object.assign(renderer.domElement.style, {
      position: 'absolute', top: '0', left: '0',
      width: '100%', height: '100%',
      pointerEvents: 'none', zIndex: '0', opacity: '0.6'
    })
    el.insertBefore(renderer.domElement, el.firstChild)

    // Golden particles
    const count = 220
    const pos = new Float32Array(count * 3)
    for (let i = 0; i < count; i++) {
      pos[i * 3]     = (Math.random() - 0.5) * 18
      pos[i * 3 + 1] = (Math.random() - 0.5) * 10
      pos[i * 3 + 2] = (Math.random() - 0.5) * 6
    }
    const geo = new THREE.BufferGeometry()
    geo.setAttribute('position', new THREE.BufferAttribute(pos, 3))
    const mat = new THREE.PointsMaterial({ color: 0xE8C87A, size: 0.045, transparent: true, opacity: 0.55, sizeAttenuation: true })
    const points = new THREE.Points(geo, mat)
    scene.add(points)

    // Secondary smaller white particles
    const pos2 = new Float32Array(120 * 3)
    for (let i = 0; i < 120; i++) {
      pos2[i * 3]     = (Math.random() - 0.5) * 18
      pos2[i * 3 + 1] = (Math.random() - 0.5) * 10
      pos2[i * 3 + 2] = (Math.random() - 0.5) * 6
    }
    const geo2 = new THREE.BufferGeometry()
    geo2.setAttribute('position', new THREE.BufferAttribute(pos2, 3))
    const mat2 = new THREE.PointsMaterial({ color: 0xffffff, size: 0.02, transparent: true, opacity: 0.25 })
    scene.add(new THREE.Points(geo2, mat2))

    this._mouse = { x: 0, y: 0 }
    this._mouseCb = (e) => {
      const rect = el.getBoundingClientRect()
      this._mouse.x = ((e.clientX - rect.left) / w - 0.5) * 2
      this._mouse.y = -((e.clientY - rect.top) / h - 0.5) * 2
    }
    el.addEventListener('mousemove', this._mouseCb)

    let frameId
    const animate = () => {
      if (this._destroyed) return
      frameId = requestAnimationFrame(animate)
      points.rotation.y += 0.0004
      points.rotation.x += 0.00015
      camera.position.x += (this._mouse.x * 0.25 - camera.position.x) * 0.04
      camera.position.y += (this._mouse.y * 0.18 - camera.position.y) * 0.04
      renderer.render(scene, camera)
    }
    animate()

    this._cancelFrame = () => { this._destroyed = true; cancelAnimationFrame(frameId) }
    this._renderer3d = renderer
  },

  setupTilt() {
    const items = this.el.querySelectorAll('[data-tilt]')
    items.forEach(item => {
      this._items.push(item)
      const onMove = (e) => {
        const r = item.getBoundingClientRect()
        const x = (e.clientX - r.left) / r.width - 0.5
        const y = (e.clientY - r.top) / r.height - 0.5
        item.style.transform = `perspective(900px) rotateX(${-y * 7}deg) rotateY(${x * 7}deg) scale(1.03)`
        item.style.zIndex = '20'
      }
      const onLeave = () => {
        item.style.transform = 'perspective(900px) rotateX(0) rotateY(0) scale(1)'
        item.style.zIndex = ''
      }
      item.addEventListener('mousemove', onMove)
      item.addEventListener('mouseleave', onLeave)
      item._glCleanup = () => { item.removeEventListener('mousemove', onMove); item.removeEventListener('mouseleave', onLeave) }
    })
  },

  setupLightbox() {
    const items = this.el.querySelectorAll('[data-src]')
    items.forEach(item => {
      item.addEventListener('click', () => {
        const src = item.dataset.src
        this._openLightbox(src, items, item)
      })
    })
  },

  _openLightbox(src, items, current) {
    const allSrcs = Array.from(items).map(i => i.dataset.src)
    let idx = allSrcs.indexOf(src)

    const overlay = document.createElement('div')
    overlay.style.cssText = 'position:fixed;inset:0;z-index:9999;background:rgba(0,0,0,0.96);display:flex;align-items:center;justify-content:center;cursor:zoom-out;backdrop-filter:blur(10px);'

    const imgEl = document.createElement('img')
    imgEl.style.cssText = 'max-width:92vw;max-height:88vh;object-fit:contain;border-radius:6px;box-shadow:0 30px 90px rgba(0,0,0,0.9);transition:opacity 0.2s ease;user-select:none;'
    imgEl.src = src

    // Prev / next buttons
    const btn = (label, dir) => {
      const b = document.createElement('button')
      b.innerHTML = dir === -1
        ? '<svg width="28" height="28" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>'
        : '<svg width="28" height="28" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>'
      b.style.cssText = `position:absolute;${dir===-1?'left:16px':'right:16px'};top:50%;transform:translateY(-50%);background:rgba(255,255,255,0.08);border:none;color:#E8C87A;border-radius:50%;width:44px;height:44px;display:flex;align-items:center;justify-content:center;cursor:pointer;transition:background 0.2s;z-index:2;`
      b.addEventListener('mouseenter', () => b.style.background = 'rgba(232,200,122,0.18)')
      b.addEventListener('mouseleave', () => b.style.background = 'rgba(255,255,255,0.08)')
      b.addEventListener('click', (e) => {
        e.stopPropagation()
        idx = (idx + dir + allSrcs.length) % allSrcs.length
        imgEl.style.opacity = '0'
        setTimeout(() => { imgEl.src = allSrcs[idx]; imgEl.style.opacity = '1' }, 160)
      })
      return b
    }
    overlay.appendChild(btn('←', -1))
    overlay.appendChild(imgEl)
    overlay.appendChild(btn('→', 1))

    const counter = document.createElement('div')
    counter.style.cssText = 'position:absolute;bottom:18px;left:50%;transform:translateX(-50%);color:#E8C87A;font-family:monospace;font-size:13px;letter-spacing:2px;'
    counter.textContent = `${idx + 1} / ${allSrcs.length}`
    imgEl.addEventListener('load', () => { counter.textContent = `${allSrcs.indexOf(imgEl.src.split('/').pop().replace(/.*\//, '')) >= 0 ? idx + 1 : idx + 1} / ${allSrcs.length}` })
    overlay.appendChild(counter)

    const close = () => { overlay.remove(); document.removeEventListener('keydown', keyH) }
    overlay.addEventListener('click', (e) => { if (e.target === overlay) close() })
    const keyH = (e) => {
      if (e.key === 'Escape') close()
      if (e.key === 'ArrowLeft') { idx = (idx - 1 + allSrcs.length) % allSrcs.length; imgEl.style.opacity = '0'; setTimeout(() => { imgEl.src = allSrcs[idx]; imgEl.style.opacity = '1' }, 160) }
      if (e.key === 'ArrowRight') { idx = (idx + 1) % allSrcs.length; imgEl.style.opacity = '0'; setTimeout(() => { imgEl.src = allSrcs[idx]; imgEl.style.opacity = '1' }, 160) }
    }
    document.addEventListener('keydown', keyH)
    document.body.appendChild(overlay)
  },

  setupEntrance() {
    const obs = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('gallery-visible')
          obs.unobserve(entry.target)
        }
      })
    }, { threshold: 0.08 })
    this.el.querySelectorAll('.gallery-item').forEach(el => obs.observe(el))
  },

  destroyed() {
    this._destroyed = true
    if (this._cancelFrame) this._cancelFrame()
    if (this._renderer3d) this._renderer3d.dispose()
    if (this._mouseCb) this.el.removeEventListener('mousemove', this._mouseCb)
    this._items.forEach(i => i._glCleanup && i._glCleanup())
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: { NavBar, MobileNav, CloseMobileNav, HeroSlider, CountDown, Gallery, Cart, MerchCart, AdminCharts, Gallery3D }
})

topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

liveSocket.connect()
window.liveSocket = liveSocket
