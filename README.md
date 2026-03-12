# 🌊 Summer Tides Festival — Official Website


<img width="1440" height="900" alt="Screenshot 2026-03-12 at 10 46 14" src="https://github.com/user-attachments/assets/606741c2-27d8-4e46-bb45-1241bc1e5b55" />


The official website for **Summer Tides: Summer Love 2026** — Kenya's premier coastal beach festival, produced by [Airbeat Global](https://www.instagram.com/summertides.fest).

**July 2–4, 2026 · Lost Beach Club, Malindi, Kenya**

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Phoenix](https://www.phoenixframework.org/) + [LiveView](https://hexdocs.pm/phoenix_live_view) |
| Language | Elixir |
| Database | PostgreSQL (via Ecto) |
| Styling | Tailwind CSS |
| Payments | [Paystack](https://paystack.com/) |
| Asset bundling | esbuild |
| Email | Swoosh |

---

## Features

- **Festival site** — Hero slideshow, artist lineup, schedule, tickets, venue map, gallery, merch, partners, FAQ
- **Merchandise shop** — Product catalog (`/merch`), individual product pages (`/merch/:id`), cart (localStorage-backed), Paystack checkout
- **Admin panel** (`/admin`) — Dashboard with Chart.js analytics, orders management, product CRUD with multi-image uploads
- **Authentication** — Admin-only login with bcrypt-hashed passwords
- **SEO** — Full Open Graph, Twitter Card, JSON-LD `MusicEvent` schema, canonical URL
- **Fully responsive** — Mobile-first design across all pages

---

## Prerequisites

- Elixir `~> 1.14`
- Erlang/OTP `~> 25`
- PostgreSQL `~> 14`
- Node.js (for esbuild/Tailwind asset compilation)

---

## Local Setup

```bash
# 1. Clone the repo
git clone https://github.com/your-org/summertidesfest.git
cd summertidesfest

# 2. Install Elixir dependencies
mix deps.get

# 3. Create and migrate the database
mix ecto.setup

# 4. Seed the database (admin user + sample products)
mix run priv/repo/seeds.exs

# 5. Start the dev server
mix phx.server
```

Visit [http://localhost:5900](http://localhost:5900) in your browser.

> The dev server runs on **port 5900** (configured in `config/dev.exs`).

---

## Seed Credentials

After running the seed, an admin account is created:

| Field | Value |
|---|---|
| Email | `admin@summertidesfest.com` |
| Password | `SummerLove2026!` |

Visit `/admin/dashboard` and log in to access the admin panel.

---

## Environment Variables

Copy `.env.example` to `.env` (or set these in your runtime config) before deploying to production:

| Variable | Description |
|---|---|
| `DATABASE_URL` | PostgreSQL connection string |
| `SECRET_KEY_BASE` | Phoenix secret key (generate with `mix phx.gen.secret`) |
| `PAYSTACK_SECRET_KEY` | Paystack secret key from your dashboard |
| `PHX_HOST` | Production hostname (e.g. `summertidesfest.com`) |

Set `PAYSTACK_SECRET_KEY` in `config/runtime.exs`:

```elixir
config :summertidesfest, :paystack_secret_key, System.get_env("PAYSTACK_SECRET_KEY")
```

---

## Project Structure

```
lib/
├── summertidesfest/
│   ├── accounts/          # User auth (Ecto + bcrypt)
│   ├── shop/              # Products, Orders, OrderItems schemas
│   ├── shop.ex            # Shop context (CRUD + analytics)
│   └── paystack.ex        # Paystack API integration (initialize + verify)
│
└── summertidesfest_web/
    ├── components/
    │   ├── admin_components.ex    # Shared admin sidebar component
    │   ├── home_components.ex     # Home page helpers
    │   └── layouts/
    │       ├── root.html.heex     # Global <head> — SEO, OG, schema.org
    │       ├── app.html.heex      # Flash messages
    │       └── admin_root.html.heex
    ├── controllers/
    │   └── payment_controller.ex  # Paystack callback + success page
    ├── live/
    │   ├── home_live/             # Main festival page
    │   ├── merch_live/            # Shop index + product detail
    │   ├── faqs_live/             # FAQ page
    │   └── admin/
    │       ├── dashboard_live/    # Chart.js analytics dashboard
    │       ├── orders_live/       # Orders table + status management
    │       └── products_live/     # Product CRUD + image uploads
    └── router.ex

priv/
├── repo/
│   ├── migrations/        # Ecto migrations
│   └── seeds.exs          # Admin user + sample products with Unsplash images
└── static/
    ├── artists/           # Artist photos
    ├── images/            # Site images, logos, sponsor assets
    ├── uploads/           # User-uploaded product images
    └── videos/            # Autoplay background reels
```

---

## Admin Panel

| Route | Description |
|---|---|
| `/admin/dashboard` | Revenue charts, order stats, recent activity |
| `/admin/orders` | Full orders list, status updates (processing → shipped → delivered) |
| `/admin/products` | Add, edit, delete products; multi-image upload |

Revenue and stats are calculated **only from shipped orders** to reflect actual money made.

---

## Payments (Paystack)

1. User fills checkout form (name, email, phone)
2. Server calls `Paystack.initialize/3` → returns `authorization_url`
3. Browser is redirected to Paystack-hosted checkout via a JS `window.location.href`
4. On completion, Paystack redirects to `/payment/callback?reference=...`
5. Server calls `Paystack.verify/1` → updates order status to `"processing"`
6. User is shown an order confirmation page at `/payment/success`

---

## Running Tests

```bash
mix test
```

---

## Deployment

### Required environment variables on the server

```bash
export MIX_ENV=prod
export DATABASE_URL="ecto://user:pass@localhost/summertidesfest_prod"
export SECRET_KEY_BASE="$(mix phx.gen.secret)"   # run once locally to generate
export PHX_HOST="summertidesfest.com"             # or your server IP
export PORT=4000
export PAYSTACK_SECRET_KEY="sk_live_..."
```

### Build & deploy steps

```bash
# 1. Install deps (prod only, no dev/test)
MIX_ENV=prod mix deps.get --only prod

# 2. Compile the app
MIX_ENV=prod mix compile

# 3. Compile assets (creates priv/static/assets/app.js + app.css + cache_manifest.json)
MIX_ENV=prod mix assets.deploy

# 4. Run database migrations
MIX_ENV=prod mix ecto.migrate

# 5. Seed the database (first deploy only)
MIX_ENV=prod mix run priv/repo/seeds.exs

# 6. Start the server
MIX_ENV=prod mix phx.server
# or as a background process:
MIX_ENV=prod PHX_SERVER=true mix phx.server
```

> ⚠️ **Never run `mix phx.server` without `MIX_ENV=prod`** on your production server.
> Running in dev mode serves uncompiled assets via a watcher process that won't be available remotely.

### `crypto.randomUUID` on plain HTTP

Phoenix LiveView calls `crypto.randomUUID()` which browsers restrict to **secure contexts** (HTTPS or `localhost`).
If you're running over plain HTTP on a bare IP address, a polyfill is already included in `assets/js/app.js` to handle this.
For production, the proper fix is to put the app behind **nginx + Let's Encrypt TLS**:

```nginx
server {
    listen 80;
    server_name summertidesfest.com;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name summertidesfest.com;

    ssl_certificate     /etc/letsencrypt/live/summertidesfest.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/summertidesfest.com/privkey.pem;

    location / {
        proxy_pass         http://127.0.0.1:4000;
        proxy_http_version 1.1;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection "upgrade";
        proxy_set_header   Host $host;
        proxy_set_header   X-Real-IP $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}
```

Run `sudo certbot --nginx -d summertidesfest.com` to generate the certificate.

---

## Credits

- Festival produced by **Airbeat Global**
- Payments by **Paystack**
- Ticketing by **Hustlesasa**
- Built with **Phoenix LiveView** & **Tailwind CSS**

---

© 2026 Airbeat Global. All rights reserved.
