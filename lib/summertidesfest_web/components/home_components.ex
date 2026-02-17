defmodule SummertidesfestWeb.HomeComponents do
  use Phoenix.Component

  def test(assigns) do
    ~H"""
    <div>
      <header class="fixed top-0 left-0 right-0 z-50 bg-dark/90 backdrop-blur-sm">
        <div class="max-w-7xl mx-auto px-6 lg:px-8 py-5 flex items-center justify-between">
          <a href="/" class="flex items-center gap-2">
            <svg width="32" height="32" viewBox="0 0 32 32" fill="none" class="text-cream">
              <path
                d="M16 2L20 10L28 12L22 18L24 26L16 22L8 26L10 18L4 12L12 10L16 2Z"
                fill="currentColor"
              />
            </svg>
            <span class="font-display text-2xl text-cream tracking-wider">JOVEXA</span>
          </a>
          <nav class="hidden md:flex items-center gap-10 text-cream/80 text-sm font-medium uppercase tracking-wider">
            <a
              href="#about"
              class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
            >
              About
            </a>

            <a
              href="#event"
              class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
            >
              Event
            </a>

            <a
              href="#services"
              class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
            >
              Services
            </a>

            <a
              href="#faq"
              class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
            >
              FAQ
            </a>

            <a
              href="#pricing"
              class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
            >
              Pricing
            </a>
          </nav>
          <a
            href="#cta"
            class="hidden md:inline-flex items-center gap-2 bg-cream text-dark px-5 py-2.5 text-sm font-semibold uppercase tracking-wider hover:bg-cream-dark transition"
          >
            Sign Up
            <svg
              width="16"
              height="16"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              stroke-width="2"
            >
              <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
            </svg>
          </a>
          <button class="md:hidden text-cream">
            <svg
              width="24"
              height="24"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              stroke-width="2"
            >
              <path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
        </div>
      </header>

      <section class="relative min-h-screen flex items-end pb-16 pt-32 overflow-hidden">
        <div class="absolute inset-0">
          <img
            src="https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=1920&q=80"
            alt="Event atmosphere"
            class="w-full h-full object-cover"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-dark via-dark/60 to-transparent"></div>
        </div>
        <div class="relative z-10 max-w-7xl mx-auto px-6 lg:px-8 w-full">
          <div class="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-8">
            <div>
              <h1 class="font-display text-[clamp(4rem,15vw,10rem)] leading-[0.85] text-cream uppercase">
                Seamless<br />Events Planning
              </h1>
            </div>
            <div class="lg:max-w-md lg:pb-4">
              <div class="flex items-baseline gap-4 mb-4">
                <span class="font-display text-5xl text-cream">15-21</span>
                <span class="text-accent text-xl font-semibold">SEP, 25</span>
              </div>
              <p class="text-cream/70 text-lg mb-8">
                Whether it's a wedding, corporate gathering, or milestone
                celebration, we make every moment extraordinary.
              </p>
              <a href="#cta" class="btn-cream text-sm font-semibold uppercase tracking-wider">
                <span class="px-6 py-4">Get in Touch</span>
                <span class="arrow-box">
                  <svg
                    width="20"
                    height="20"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    stroke-width="2"
                  >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                  </svg>
                </span>
              </a>
            </div>
          </div>
        </div>
      </section>
      
    <!-- Gallery Section -->
      <section class="py-24 bg-dark">
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="flex flex-col">
              <p class="text-cream text-xl font-medium mb-6 max-w-xs">
                We transform visions into reality, creating immersive experiences
              </p>
              <div class="aspect-[4/5] overflow-hidden rounded-lg">
                <img
                  src="https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=600&q=80"
                  alt="Festival performer"
                  class="w-full h-full object-cover hover:scale-105 transition duration-700"
                />
              </div>
            </div>
            <div class="flex flex-col">
              <div class="aspect-[4/5] overflow-hidden rounded-lg mb-6">
                <img
                  src="https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=600&q=80"
                  alt="Concert crowd"
                  class="w-full h-full object-cover hover:scale-105 transition duration-700"
                />
              </div>
              <p class="text-cream text-xl font-medium max-w-xs">
                We transform visions into reality, creating immersive experiences
              </p>
            </div>
            <div class="flex flex-col justify-center">
              <div class="aspect-[4/5] overflow-hidden rounded-lg">
                <img
                  src="https://images.unsplash.com/photo-1429962714451-bb934ecdc4ec?w=600&q=80"
                  alt="Happy attendee"
                  class="w-full h-full object-cover hover:scale-105 transition duration-700"
                />
              </div>
            </div>
          </div>
        </div>
      </section>
      
    <!-- About Section -->
      <section id="about" class="py-24 bg-dark">
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <div class="flex flex-col lg:flex-row gap-16 items-center">
            <div class="lg:w-1/2">
              <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-8">
                About Event
              </h2>
              <p class="text-cream/70 text-lg mb-10 max-w-lg">
                Our team of expert event planners is committed to designing
                experiences that resonate long after the last guest leaves.
                Whether it's a wedding, corporate gathering, or milestone
                celebration, we make every moment extraordinary.
              </p>
              <div class="flex gap-12 mb-10 border-t border-white/10 pt-10">
                <div>
                  <div class="font-display text-5xl text-cream">32+</div>
                  <div class="text-cream/50 text-sm uppercase tracking-wider mt-1">
                    Sessions
                  </div>
                </div>
                <div>
                  <div class="font-display text-5xl text-cream">99%</div>
                  <div class="text-cream/50 text-sm uppercase tracking-wider mt-1">
                    Event Success
                  </div>
                </div>
                <div>
                  <div class="font-display text-5xl text-cream">6K+</div>
                  <div class="text-cream/50 text-sm uppercase tracking-wider mt-1">
                    Attender
                  </div>
                </div>
              </div>
              <a href="#cta" class="btn-cream text-sm font-semibold uppercase tracking-wider">
                <span class="px-6 py-4">Get in Touch</span>
                <span class="arrow-box">
                  <svg
                    width="20"
                    height="20"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    stroke-width="2"
                  >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                  </svg>
                </span>
              </a>
            </div>
            <div class="lg:w-1/2">
              <div class="aspect-[3/4] overflow-hidden rounded-lg">
                <img
                  src="https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=800&q=80"
                  alt="Festival crowd"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
          </div>
        </div>
      </section>
      
    <!-- Services Section -->
      <section id="services" class="py-24 bg-dark">
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <div class="text-center mb-16">
            <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-6">
              Our Services
            </h2>
            <p class="text-cream/60 text-lg max-w-2xl mx-auto">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse
              dolor turpis, dictum a efficitur in, aliquam eget velit.
            </p>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="service-card">
              <h3 class="font-display text-4xl text-cream uppercase mb-6">
                Private Parties
              </h3>
              <p class="text-accent font-semibold mb-4">Donec a neque a ligula</p>
              <p class="text-cream/60">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                Suspendisse dolor turpis, dictum a efficitur in, aliquam eget
                velit.
              </p>
            </div>
            <div class="service-card">
              <h3 class="font-display text-4xl text-cream uppercase mb-6">
                Modern Weddings
              </h3>
              <p class="text-accent font-semibold mb-4">Donec a neque a ligula</p>
              <p class="text-cream/60">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                Suspendisse dolor turpis, dictum a efficitur in, aliquam eget
                velit.
              </p>
            </div>
            <div class="service-card">
              <h3 class="font-display text-4xl text-cream uppercase mb-6">
                Destination Events
              </h3>
              <p class="text-accent font-semibold mb-4">Donec a neque a ligula</p>
              <p class="text-cream/60">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                Suspendisse dolor turpis, dictum a efficitur in, aliquam eget
                velit.
              </p>
            </div>
          </div>
        </div>
      </section>
      
    <!-- Event Venues Section -->
      <section id="event" class="py-24 bg-dark">
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-12">
            Event Venues
          </h2>
          <div class="space-y-0">
            <div class="venue-item group flex items-center justify-between">
              <div>
                <h3 class="font-display text-3xl text-cream uppercase mb-2">
                  Elegant & Versatile Spaces
                </h3>
                <p class="text-cream/50">
                  From grand ballrooms to chic outdoor setups.
                </p>
              </div>
              <div class="text-cream/30 group-hover:text-cream transition">
                <svg
                  width="24"
                  height="24"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M7 17L17 7M17 7H7M17 7V17" />
                </svg>
              </div>
            </div>
            <div class="venue-item group flex items-center justify-between">
              <div>
                <h3 class="font-display text-3xl text-cream uppercase mb-2">
                  Customizable Decor & Ambiance
                </h3>
                <p class="text-cream/50">
                  Transform venues to match your vision.
                </p>
              </div>
              <div class="text-cream/30 group-hover:text-cream transition">
                <svg
                  width="24"
                  height="24"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M7 17L17 7M17 7H7M17 7V17" />
                </svg>
              </div>
            </div>
            <div class="venue-item group flex items-center justify-between">
              <div>
                <h3 class="font-display text-3xl text-cream uppercase mb-2">
                  State-of-the-Art Facilities
                </h3>
                <p class="text-cream/50">
                  Advanced lighting, sound, and staging.
                </p>
              </div>
              <div class="text-cream/30 group-hover:text-cream transition">
                <svg
                  width="24"
                  height="24"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M7 17L17 7M17 7H7M17 7V17" />
                </svg>
              </div>
            </div>
            <div class="venue-item group flex items-center justify-between border-b-0">
              <div>
                <h3 class="font-display text-3xl text-cream uppercase mb-2">
                  Seamless Coordination
                </h3>
                <p class="text-cream/50">
                  We handle everything for a stress-free experience.
                </p>
              </div>
              <div class="text-cream/30 group-hover:text-cream transition">
                <svg
                  width="24"
                  height="24"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M7 17L17 7M17 7H7M17 7V17" />
                </svg>
              </div>
            </div>
          </div>
        </div>
      </section>
      
    <!-- Pricing Section -->
      <section id="pricing" class="py-24 bg-dark">
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <div class="mb-16">
            <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-6">
              Get Pricing
            </h2>
            <p class="text-cream/60 text-lg max-w-2xl">
              Choose the perfect package for an unforgettable event with Jovexa.
              Whether you're looking for exclusive VIP package or a general.
            </p>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="service-card flex flex-col">
              <h3 class="font-display text-3xl text-cream uppercase mb-4">
                General Package
              </h3>
              <p class="text-cream/50 mb-6">
                Affordable rates with all features.
              </p>
              <div class="flex items-baseline gap-2 mb-6">
                <span class="font-display text-5xl text-cream">$2000</span>
                <span class="text-cream/50">/Six Hour</span>
              </div>
              <ul class="text-cream/60 space-y-3 mb-8 flex-grow">
                <li class="flex items-start gap-3">
                  <svg
                    class="w-5 h-5 text-accent mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Premium area six hour seating
                </li>
                <li class="flex items-start gap-3">
                  <svg
                    class="w-5 h-5 text-accent mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Exclusive VIP lounge access
                </li>
              </ul>
              <a
                href="#cta"
                class="btn-cream text-sm font-semibold uppercase tracking-wider w-full justify-center"
              >
                <span class="px-6 py-3">Get in Touch</span>
              </a>
            </div>
            <div class="service-card flex flex-col">
              <h3 class="font-display text-3xl text-cream uppercase mb-4">
                Standard Package
              </h3>
              <p class="text-cream/50 mb-6">
                Affordable rates with all features.
              </p>
              <div class="flex items-baseline gap-2 mb-6">
                <span class="font-display text-5xl text-cream">$3220</span>
                <span class="text-cream/50">/Six Hour</span>
              </div>
              <ul class="text-cream/60 space-y-3 mb-8 flex-grow">
                <li class="flex items-start gap-3">
                  <svg
                    class="w-5 h-5 text-accent mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Premium area six hour seating
                </li>
                <li class="flex items-start gap-3">
                  <svg
                    class="w-5 h-5 text-accent mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Exclusive VIP lounge access
                </li>
                <li class="flex items-start gap-3">
                  <svg
                    class="w-5 h-5 text-accent mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Gourmet dining & luxury perks
                </li>
              </ul>
              <a
                href="#cta"
                class="btn-cream text-sm font-semibold uppercase tracking-wider w-full justify-center"
              >
                <span class="px-6 py-3">Get in Touch</span>
              </a>
            </div>
            <div class="service-card flex flex-col">
              <h3 class="font-display text-3xl text-cream uppercase mb-4">
                VIP Package
              </h3>
              <p class="text-cream/50 mb-6">
                Affordable rates with all features.
              </p>
              <div class="flex items-baseline gap-2 mb-6">
                <span class="font-display text-5xl text-cream">$4040</span>
                <span class="text-cream/50">/Fifteen Hour</span>
              </div>
              <ul class="text-cream/60 space-y-3 mb-8 flex-grow">
                <li class="flex items-start gap-3">
                  <svg
                    class="w-5 h-5 text-accent mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Premium area six hour seating
                </li>
                <li class="flex items-start gap-3">
                  <svg
                    class="w-5 h-5 text-accent mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Exclusive VIP lounge access
                </li>
                <li class="flex items-start gap-3">
                  <svg
                    class="w-5 h-5 text-accent mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Gourmet dining & luxury perks
                </li>
                <li class="flex items-start gap-3">
                  <svg
                    class="w-5 h-5 text-accent mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Meet-and-greet with speakers
                </li>
              </ul>
              <a
                href="#cta"
                class="btn-cream text-sm font-semibold uppercase tracking-wider w-full justify-center"
              >
                <span class="px-6 py-3">Get in Touch</span>
              </a>
            </div>
          </div>
        </div>
      </section>
      
    <!-- Upcoming Event Section -->
      <section class="py-24 bg-dark">
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <div class="flex flex-col lg:flex-row gap-16 items-center">
            <div class="lg:w-1/2">
              <div class="aspect-[3/4] overflow-hidden rounded-lg">
                <img
                  src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&q=80"
                  alt="Event organizer"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
            <div class="lg:w-1/2">
              <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-8">
                Upcoming Event
              </h2>
              <p class="text-cream/70 text-lg mb-8 max-w-lg">
                Join us at our upcoming events for an opportunity to see our work
                firsthand, connect with our planners, and get inspired for your
                own celebration.
              </p>
              <div class="border-t border-white/10 pt-8 mb-8">
                <h3 class="font-display text-2xl text-cream uppercase">
                  Day 03 - Session 05 Starts From 09:00
                </h3>
              </div>
              <a href="#cta" class="btn-cream text-sm font-semibold uppercase tracking-wider">
                <span class="px-6 py-4">Get in Touch</span>
                <span class="arrow-box">
                  <svg
                    width="20"
                    height="20"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    stroke-width="2"
                  >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                  </svg>
                </span>
              </a>
            </div>
          </div>
        </div>
      </section>

      <section class="py-20 bg-dark border-t border-white/5">
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <h2 class="text-cream/50 text-sm uppercase tracking-wider mb-10">
            Supported by
          </h2>
          <div class="flex flex-wrap gap-12 items-center opacity-50">
            <div class="font-display text-2xl text-cream">ACME Co.</div>
            <div class="font-display text-2xl text-cream">Globex</div>
            <div class="font-display text-2xl text-cream">Initech</div>
            <div class="font-display text-2xl text-cream">Umbrella</div>
            <div class="font-display text-2xl text-cream">Hooli</div>
            <div class="font-display text-2xl text-cream">Massive</div>
          </div>
        </div>
      </section>
      
    <!-- FAQ Section -->
      <section id="faq" class="py-24 bg-dark">
        <div class="max-w-4xl mx-auto px-6 lg:px-8">
          <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-16">
            Asked Questions
          </h2>
          <div class="space-y-0">
            <details class="faq-item py-6 group">
              <summary class="flex items-center justify-between text-cream text-lg font-medium">
                How does the Agile Manifesto address planning?
                <svg
                  class="faq-arrow w-5 h-5 transition-transform duration-300"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
                </svg>
              </summary>
              <p class="mt-4 text-cream/60 pr-12">
                Experts discuss how technology and creativity are transforming
                event experiences.
              </p>
            </details>
            <details class="faq-item py-6 group">
              <summary class="flex items-center justify-between text-cream text-lg font-medium">
                Any student discount is there?
                <svg
                  class="faq-arrow w-5 h-5 transition-transform duration-300"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
                </svg>
              </summary>
              <p class="mt-4 text-cream/60 pr-12">
                Thought leaders share insights on how digital tools and
                storytelling are revolutionizing marketing strategies.
              </p>
            </details>
            <details class="faq-item py-6 group">
              <summary class="flex items-center justify-between text-cream text-lg font-medium">
                What is minimum age to attend the event?
                <svg
                  class="faq-arrow w-5 h-5 transition-transform duration-300"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
                </svg>
              </summary>
              <p class="mt-4 text-cream/60 pr-12">
                Experts examine how immersive technology and artistic expression
                are redefining audience engagement.
              </p>
            </details>
            <details class="faq-item py-6 group border-b-0">
              <summary class="flex items-center justify-between text-cream text-lg font-medium">
                Are the event beginner-friendly?
                <svg
                  class="faq-arrow w-5 h-5 transition-transform duration-300"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
                </svg>
              </summary>
              <p class="mt-4 text-cream/60 pr-12">
                Industry professionals highlight how data-driven design and
                creative collaboration are transforming user journeys.
              </p>
            </details>
          </div>
        </div>
      </section>
      
    <!-- Testimonials Section -->
      <section class="py-24 bg-dark">
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-16">
            Testimonials
          </h2>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="service-card text-center">
              <p class="text-cream text-xl font-medium mb-8">
                "Memorable moments, expertly crafted!"
              </p>
              <div class="w-20 h-20 mx-auto rounded-full overflow-hidden">
                <img
                  src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80"
                  alt="Testimonial"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
            <div class="service-card text-center">
              <p class="text-cream text-xl font-medium mb-8">
                "Jovexa made planning stress-free!"
              </p>
              <div class="w-20 h-20 mx-auto rounded-full overflow-hidden">
                <img
                  src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80"
                  alt="Testimonial"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
            <div class="service-card text-center">
              <p class="text-cream text-xl font-medium mb-8">
                "Seamless event from start to finish!"
              </p>
              <div class="w-20 h-20 mx-auto rounded-full overflow-hidden">
                <img
                  src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80"
                  alt="Testimonial"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
          </div>
        </div>
      </section>
      
    <!-- CTA Section -->
      <section id="cta" class="py-24 bg-cream">
        <div class="max-w-3xl mx-auto px-6 lg:px-8 text-center">
          <h2 class="font-display text-[clamp(2.5rem,6vw,4rem)] leading-[0.9] text-dark uppercase mb-8">
            Ready to Host Your Next Event?
          </h2>
          <form class="flex flex-col sm:flex-row gap-4 justify-center items-center mb-6">
            <input
              type="email"
              name="email"
              placeholder="Enter your email"
              required
              class="px-6 py-4 bg-dark text-cream placeholder-cream/50 w-full sm:w-80 focus:outline-none focus:ring-2 focus:ring-accent"
            />
            <button
              type="submit"
              class="px-8 py-4 bg-dark text-cream font-semibold uppercase tracking-wider hover:bg-dark/90 transition w-full sm:w-auto"
            >
              Submit
            </button>
          </form>
          <p class="text-dark/70">We'll get in touch soon!</p>
        </div>
      </section>

      <footer class="py-16 bg-dark border-t border-white/5">
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <div class="flex flex-col md:flex-row justify-between items-start gap-12">
            <div>
              <div class="flex items-center gap-2 mb-6">
                <svg width="32" height="32" viewBox="0 0 32 32" fill="none" class="text-cream">
                  <path
                    d="M16 2L20 10L28 12L22 18L24 26L16 22L8 26L10 18L4 12L12 10L16 2Z"
                    fill="currentColor"
                  />
                </svg>
                <span class="font-display text-2xl text-cream tracking-wider">JOVEXA</span>
              </div>
              <div class="text-cream/60 space-y-2">
                <p>
                  Email:
                  <a href="mailto:info@jovexa.com" class="text-cream hover:text-accent transition">
                    info@jovexa.com
                  </a>
                </p>
                <p>
                  <a href="tel:+15551234567" class="text-cream hover:text-accent transition">
                    +1 (555) 123-4567
                  </a>
                </p>
                <p>123 Event Street, New York, NY 10001, USA</p>
              </div>
            </div>
            <div class="flex gap-6">
              <a href="#" class="text-cream/50 hover:text-cream transition">
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" />
                </svg>
              </a>
              <a href="#" class="text-cream/50 hover:text-cream transition">
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z" />
                </svg>
              </a>
              <a href="#" class="text-cream/50 hover:text-cream transition">
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" />
                </svg>
              </a>
              <a href="#" class="text-cream/50 hover:text-cream transition">
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M9 8h-3v4h3v12h5v-12h3.642l.358-4h-4v-1.667c0-.955.192-1.333 1.115-1.333h2.885v-5h-3.808c-3.596 0-5.192 1.583-5.192 4.615v3.385z" />
                </svg>
              </a>
            </div>
          </div>
          <div class="mt-12 pt-8 border-t border-white/5 text-center text-cream/40 text-sm">
            © 2025 Jovexa. All rights reserved.
          </div>
        </div>
      </footer>
    </div>
    """
  end

  def home_header(assigns) do
    ~H"""
    <header class="fixed top-0 left-0 right-0 z-50 bg-dark/90 backdrop-blur-sm">
      <div class="max-w-7xl mx-auto px-6 lg:px-8 py-5 flex items-center justify-between">
        <a href="/" class="flex items-center gap-2">
          <svg width="32" height="32" viewBox="0 0 32 32" fill="none" class="text-cream">
            <path
              d="M16 2L20 10L28 12L22 18L24 26L16 22L8 26L10 18L4 12L12 10L16 2Z"
              fill="currentColor"
            />
          </svg>
          <span class="font-display text-2xl text-cream tracking-wider">JOVEXA</span>
        </a>
        <nav class="hidden md:flex items-center gap-10 text-cream/80 text-sm font-medium uppercase tracking-wider">
          <a
            href="#about"
            class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
          >
            About
          </a>

          <a
            href="#event"
            class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
          >
            Event
          </a>

          <a
            href="#services"
            class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
          >
            Services
          </a>

          <a
            href="#faq"
            class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
          >
            FAQ
          </a>

          <a
            href="#pricing"
            class="hover:text-cream transition border-b border-transparent hover:border-cream pb-1"
          >
            Pricing
          </a>
        </nav>
        <a
          href="#cta"
          class="hidden md:inline-flex items-center gap-2 bg-cream text-dark px-5 py-2.5 text-sm font-semibold uppercase tracking-wider hover:bg-cream-dark transition"
        >
          Sign Up
          <svg
            width="16"
            height="16"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            stroke-width="2"
          >
            <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
          </svg>
        </a>
        <button class="md:hidden text-cream">
          <svg
            width="24"
            height="24"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            stroke-width="2"
          >
            <path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
      </div>
    </header>
    """
  end

  def home_hero(assigns) do
    ~H"""
    <section class="relative min-h-screen flex items-end pb-16 pt-32 overflow-hidden">
      <div class="absolute inset-0">
        <img
          src="https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=1920&q=80"
          alt="Event atmosphere"
          class="w-full h-full object-cover"
        />
        <div class="absolute inset-0 bg-gradient-to-t from-dark via-dark/60 to-transparent"></div>
      </div>
      <div class="relative z-10 max-w-7xl mx-auto px-6 lg:px-8 w-full">
        <div class="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-8">
          <div>
            <h1 class="font-display text-[clamp(4rem,15vw,10rem)] leading-[0.85] text-cream uppercase">
              Seamless<br />Events Planning
            </h1>
          </div>
          <div class="lg:max-w-md lg:pb-4">
            <div class="flex items-baseline gap-4 mb-4">
              <span class="font-display text-5xl text-cream">15-21</span>
              <span class="text-accent text-xl font-semibold">SEP, 25</span>
            </div>
            <p class="text-cream/70 text-lg mb-8">
              Whether it's a wedding, corporate gathering, or milestone
              celebration, we make every moment extraordinary.
            </p>
            <a href="#cta" class="btn-cream text-sm font-semibold uppercase tracking-wider">
              <span class="px-6 py-4">Get in Touch</span>
              <span class="arrow-box">
                <svg
                  width="20"
                  height="20"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                </svg>
              </span>
            </a>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def home_gallery(assigns) do
    ~H"""
    <section class="py-24 bg-dark">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div class="flex flex-col">
            <p class="text-cream text-xl font-medium mb-6 max-w-xs">
              We transform visions into reality, creating immersive experiences
            </p>
            <div class="aspect-[4/5] overflow-hidden rounded-lg">
              <img
                src="https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=600&q=80"
                alt="Festival performer"
                class="w-full h-full object-cover hover:scale-105 transition duration-700"
              />
            </div>
          </div>
          <div class="flex flex-col">
            <div class="aspect-[4/5] overflow-hidden rounded-lg mb-6">
              <img
                src="https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=600&q=80"
                alt="Concert crowd"
                class="w-full h-full object-cover hover:scale-105 transition duration-700"
              />
            </div>
            <p class="text-cream text-xl font-medium max-w-xs">
              We transform visions into reality, creating immersive experiences
            </p>
          </div>
          <div class="flex flex-col justify-center">
            <div class="aspect-[4/5] overflow-hidden rounded-lg">
              <img
                src="https://images.unsplash.com/photo-1429962714451-bb934ecdc4ec?w=600&q=80"
                alt="Happy attendee"
                class="w-full h-full object-cover hover:scale-105 transition duration-700"
              />
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def home_about(assigns) do
    ~H"""
    <section id="about" class="py-24 bg-dark">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <div class="flex flex-col lg:flex-row gap-16 items-center">
          <div class="lg:w-1/2">
            <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-8">
              About Event
            </h2>
            <p class="text-cream/70 text-lg mb-10 max-w-lg">
              Our team of expert event planners is committed to designing
              experiences that resonate long after the last guest leaves.
              Whether it's a wedding, corporate gathering, or milestone
              celebration, we make every moment extraordinary.
            </p>
            <div class="flex gap-12 mb-10 border-t border-white/10 pt-10">
              <div>
                <div class="font-display text-5xl text-cream">32+</div>
                <div class="text-cream/50 text-sm uppercase tracking-wider mt-1">
                  Sessions
                </div>
              </div>
              <div>
                <div class="font-display text-5xl text-cream">99%</div>
                <div class="text-cream/50 text-sm uppercase tracking-wider mt-1">
                  Event Success
                </div>
              </div>
              <div>
                <div class="font-display text-5xl text-cream">6K+</div>
                <div class="text-cream/50 text-sm uppercase tracking-wider mt-1">
                  Attender
                </div>
              </div>
            </div>
            <a href="#cta" class="btn-cream text-sm font-semibold uppercase tracking-wider">
              <span class="px-6 py-4">Get in Touch</span>
              <span class="arrow-box">
                <svg
                  width="20"
                  height="20"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                </svg>
              </span>
            </a>
          </div>
          <div class="lg:w-1/2">
            <div class="aspect-[3/4] overflow-hidden rounded-lg">
              <img
                src="https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=800&q=80"
                alt="Festival crowd"
                class="w-full h-full object-cover"
              />
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def home_services(assigns) do
    ~H"""
    <section id="services" class="py-24 bg-dark">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-6">
            Our Services
          </h2>
          <p class="text-cream/60 text-lg max-w-2xl mx-auto">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse
            dolor turpis, dictum a efficitur in, aliquam eget velit.
          </p>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div class="service-card">
            <h3 class="font-display text-4xl text-cream uppercase mb-6">
              Private Parties
            </h3>
            <p class="text-accent font-semibold mb-4">Donec a neque a ligula</p>
            <p class="text-cream/60">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              Suspendisse dolor turpis, dictum a efficitur in, aliquam eget
              velit.
            </p>
          </div>
          <div class="service-card">
            <h3 class="font-display text-4xl text-cream uppercase mb-6">
              Modern Weddings
            </h3>
            <p class="text-accent font-semibold mb-4">Donec a neque a ligula</p>
            <p class="text-cream/60">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              Suspendisse dolor turpis, dictum a efficitur in, aliquam eget
              velit.
            </p>
          </div>
          <div class="service-card">
            <h3 class="font-display text-4xl text-cream uppercase mb-6">
              Destination Events
            </h3>
            <p class="text-accent font-semibold mb-4">Donec a neque a ligula</p>
            <p class="text-cream/60">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              Suspendisse dolor turpis, dictum a efficitur in, aliquam eget
              velit.
            </p>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def home_event_venues(assigns) do
    ~H"""
    <section id="event" class="py-24 bg-dark">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-12">
          Event Venues
        </h2>
        <div class="space-y-0">
          <div class="venue-item group flex items-center justify-between">
            <div>
              <h3 class="font-display text-3xl text-cream uppercase mb-2">
                Elegant & Versatile Spaces
              </h3>
              <p class="text-cream/50">
                From grand ballrooms to chic outdoor setups.
              </p>
            </div>
            <div class="text-cream/30 group-hover:text-cream transition">
              <svg
                width="24"
                height="24"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                stroke-width="2"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M7 17L17 7M17 7H7M17 7V17" />
              </svg>
            </div>
          </div>
          <div class="venue-item group flex items-center justify-between">
            <div>
              <h3 class="font-display text-3xl text-cream uppercase mb-2">
                Customizable Decor & Ambiance
              </h3>
              <p class="text-cream/50">
                Transform venues to match your vision.
              </p>
            </div>
            <div class="text-cream/30 group-hover:text-cream transition">
              <svg
                width="24"
                height="24"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                stroke-width="2"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M7 17L17 7M17 7H7M17 7V17" />
              </svg>
            </div>
          </div>
          <div class="venue-item group flex items-center justify-between">
            <div>
              <h3 class="font-display text-3xl text-cream uppercase mb-2">
                State-of-the-Art Facilities
              </h3>
              <p class="text-cream/50">
                Advanced lighting, sound, and staging.
              </p>
            </div>
            <div class="text-cream/30 group-hover:text-cream transition">
              <svg
                width="24"
                height="24"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                stroke-width="2"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M7 17L17 7M17 7H7M17 7V17" />
              </svg>
            </div>
          </div>
          <div class="venue-item group flex items-center justify-between border-b-0">
            <div>
              <h3 class="font-display text-3xl text-cream uppercase mb-2">
                Seamless Coordination
              </h3>
              <p class="text-cream/50">
                We handle everything for a stress-free experience.
              </p>
            </div>
            <div class="text-cream/30 group-hover:text-cream transition">
              <svg
                width="24"
                height="24"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                stroke-width="2"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M7 17L17 7M17 7H7M17 7V17" />
              </svg>
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def home_rewind_time(assigns) do
    ~H"""
    <section class="py-24 bg-dark">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-20 text-center">
          Its Rewind Time
        </h2>
        <div class="relative">
          <div class="timeline-line hidden lg:block"></div>

          <div class="relative flex flex-col lg:flex-row items-center gap-8 mb-24">
            <div class="lg:w-1/2 lg:pr-16 lg:text-right order-2 lg:order-1">
              <h3 class="font-display text-3xl text-cream mb-2">Jan 2021</h3>
              <p class="text-cream/60">
                Elegant evening with 300+ professionals and live jazz.
              </p>
            </div>
            <div class="timeline-dot hidden lg:block" style="top: 50%"></div>
            <div class="lg:w-1/2 lg:pl-16 order-1 lg:order-2">
              <div class="aspect-video overflow-hidden rounded-lg">
                <img
                  src="https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=600&q=80"
                  alt="January event"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
          </div>

          <div class="relative flex flex-col lg:flex-row items-center gap-8 mb-24">
            <div class="lg:w-1/2 lg:pr-16 order-1">
              <div class="aspect-video overflow-hidden rounded-lg">
                <img
                  src="https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&q=80"
                  alt="February event"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
            <div class="timeline-dot hidden lg:block" style="top: 50%"></div>
            <div class="lg:w-1/2 lg:pl-16 order-2">
              <h3 class="font-display text-3xl text-cream mb-2">Feb 2021</h3>
              <p class="text-cream/60">
                2-day summit with 20+ speakers and interactive demos.
              </p>
            </div>
          </div>

          <div class="relative flex flex-col lg:flex-row items-center gap-8 mb-24">
            <div class="lg:w-1/2 lg:pr-16 lg:text-right order-2 lg:order-1">
              <h3 class="font-display text-3xl text-cream mb-2">Apr 2021</h3>
              <p class="text-cream/60">
                Inspiration-filled day with luxury setups and floral art.
              </p>
            </div>
            <div class="timeline-dot hidden lg:block" style="top: 50%"></div>
            <div class="lg:w-1/2 lg:pl-16 order-1 lg:order-2">
              <div class="aspect-video overflow-hidden rounded-lg">
                <img
                  src="https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=600&q=80"
                  alt="April event"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
          </div>

          <div class="relative flex flex-col lg:flex-row items-center gap-8">
            <div class="lg:w-1/2 lg:pr-16 order-1">
              <div class="aspect-video overflow-hidden rounded-lg">
                <img
                  src="https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=600&q=80"
                  alt="May event"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
            <div class="timeline-dot hidden lg:block" style="top: 50%"></div>
            <div class="lg:w-1/2 lg:pl-16 order-2">
              <h3 class="font-display text-3xl text-cream mb-2">May 2021</h3>
              <p class="text-cream/60">
                5,000+ guests. 3 days. Non-stop music and energy.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def home_upcoming_events(assigns) do
    ~H"""
    <section class="py-24 bg-dark">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <div class="flex flex-col lg:flex-row gap-16 items-center">
          <div class="lg:w-1/2">
            <div class="aspect-[3/4] overflow-hidden rounded-lg">
              <img
                src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&q=80"
                alt="Event organizer"
                class="w-full h-full object-cover"
              />
            </div>
          </div>
          <div class="lg:w-1/2">
            <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-8">
              Upcoming Event
            </h2>
            <p class="text-cream/70 text-lg mb-8 max-w-lg">
              Join us at our upcoming events for an opportunity to see our work
              firsthand, connect with our planners, and get inspired for your
              own celebration.
            </p>
            <div class="border-t border-white/10 pt-8 mb-8">
              <h3 class="font-display text-2xl text-cream uppercase">
                Day 03 - Session 05 Starts From 09:00
              </h3>
            </div>
            <a href="#cta" class="btn-cream text-sm font-semibold uppercase tracking-wider">
              <span class="px-6 py-4">Get in Touch</span>
              <span class="arrow-box">
                <svg
                  width="20"
                  height="20"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                </svg>
              </span>
            </a>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def home_supported_by(assigns) do
    ~H"""
    <section class="py-20 bg-dark border-t border-white/5">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <h2 class="text-cream/50 text-sm uppercase tracking-wider mb-10">
          Supported by
        </h2>
        <div class="flex flex-wrap gap-12 items-center opacity-50">
          <div class="font-display text-2xl text-cream">ACME Co.</div>
          <div class="font-display text-2xl text-cream">Globex</div>
          <div class="font-display text-2xl text-cream">Initech</div>
          <div class="font-display text-2xl text-cream">Umbrella</div>
          <div class="font-display text-2xl text-cream">Hooli</div>
          <div class="font-display text-2xl text-cream">Massive</div>
        </div>
      </div>
    </section>
    """
  end

  def home_faq(assigns) do
    ~H"""
    <section id="faq" class="py-24 bg-dark">
      <div class="max-w-4xl mx-auto px-6 lg:px-8">
        <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-16">
          Asked Questions
        </h2>
        <div class="space-y-0">
          <details class="faq-item py-6 group">
            <summary class="flex items-center justify-between text-cream text-lg font-medium">
              How does the Agile Manifesto address planning?
              <svg
                class="faq-arrow w-5 h-5 transition-transform duration-300"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                stroke-width="2"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
              </svg>
            </summary>
            <p class="mt-4 text-cream/60 pr-12">
              Experts discuss how technology and creativity are transforming
              event experiences.
            </p>
          </details>
          <details class="faq-item py-6 group">
            <summary class="flex items-center justify-between text-cream text-lg font-medium">
              Any student discount is there?
              <svg
                class="faq-arrow w-5 h-5 transition-transform duration-300"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                stroke-width="2"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
              </svg>
            </summary>
            <p class="mt-4 text-cream/60 pr-12">
              Thought leaders share insights on how digital tools and
              storytelling are revolutionizing marketing strategies.
            </p>
          </details>
          <details class="faq-item py-6 group">
            <summary class="flex items-center justify-between text-cream text-lg font-medium">
              What is minimum age to attend the event?
              <svg
                class="faq-arrow w-5 h-5 transition-transform duration-300"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                stroke-width="2"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
              </svg>
            </summary>
            <p class="mt-4 text-cream/60 pr-12">
              Experts examine how immersive technology and artistic expression
              are redefining audience engagement.
            </p>
          </details>
          <details class="faq-item py-6 group border-b-0">
            <summary class="flex items-center justify-between text-cream text-lg font-medium">
              Are the event beginner-friendly?
              <svg
                class="faq-arrow w-5 h-5 transition-transform duration-300"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                stroke-width="2"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
              </svg>
            </summary>
            <p class="mt-4 text-cream/60 pr-12">
              Industry professionals highlight how data-driven design and
              creative collaboration are transforming user journeys.
            </p>
          </details>
        </div>
      </div>
    </section>
    """
  end

  def home_testimonials(assigns) do
    ~H"""
    <section class="py-24 bg-dark">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <h2 class="font-display text-[clamp(3rem,8vw,6rem)] leading-[0.9] text-cream uppercase mb-16">
          Testimonials
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="service-card text-center">
            <p class="text-cream text-xl font-medium mb-8">
              "Memorable moments, expertly crafted!"
            </p>
            <div class="w-20 h-20 mx-auto rounded-full overflow-hidden">
              <img
                src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80"
                alt="Testimonial"
                class="w-full h-full object-cover"
              />
            </div>
          </div>
          <div class="service-card text-center">
            <p class="text-cream text-xl font-medium mb-8">
              "Jovexa made planning stress-free!"
            </p>
            <div class="w-20 h-20 mx-auto rounded-full overflow-hidden">
              <img
                src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80"
                alt="Testimonial"
                class="w-full h-full object-cover"
              />
            </div>
          </div>
          <div class="service-card text-center">
            <p class="text-cream text-xl font-medium mb-8">
              "Seamless event from start to finish!"
            </p>
            <div class="w-20 h-20 mx-auto rounded-full overflow-hidden">
              <img
                src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80"
                alt="Testimonial"
                class="w-full h-full object-cover"
              />
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def home_cta(assigns) do
    ~H"""
    <section id="cta" class="py-24 bg-cream">
      <div class="max-w-3xl mx-auto px-6 lg:px-8 text-center">
        <h2 class="font-display text-[clamp(2.5rem,6vw,4rem)] leading-[0.9] text-dark uppercase mb-8">
          Ready to Host Your Next Event?
        </h2>
        <form class="flex flex-col sm:flex-row gap-4 justify-center items-center mb-6">
          <input
            type="email"
            name="email"
            placeholder="Enter your email"
            required
            class="px-6 py-4 bg-dark text-cream placeholder-cream/50 w-full sm:w-80 focus:outline-none focus:ring-2 focus:ring-accent"
          />
          <button
            type="submit"
            class="px-8 py-4 bg-dark text-cream font-semibold uppercase tracking-wider hover:bg-dark/90 transition w-full sm:w-auto"
          >
            Submit
          </button>
        </form>
        <p class="text-dark/70">We'll get in touch soon!</p>
      </div>
    </section>
    """
  end

  def home_footer(assigns) do
    ~H"""
    <footer class="py-16 bg-dark border-t border-white/5">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <div class="flex flex-col md:flex-row justify-between items-start gap-12">
          <div>
            <div class="flex items-center gap-2 mb-6">
              <svg width="32" height="32" viewBox="0 0 32 32" fill="none" class="text-cream">
                <path
                  d="M16 2L20 10L28 12L22 18L24 26L16 22L8 26L10 18L4 12L12 10L16 2Z"
                  fill="currentColor"
                />
              </svg>
              <span class="font-display text-2xl text-cream tracking-wider">JOVEXA</span>
            </div>
            <div class="text-cream/60 space-y-2">
              <p>
                Email:
                <a href="mailto:info@jovexa.com" class="text-cream hover:text-accent transition">
                  info@jovexa.com
                </a>
              </p>
              <p>
                <a href="tel:+15551234567" class="text-cream hover:text-accent transition">
                  +1 (555) 123-4567
                </a>
              </p>
              <p>123 Event Street, New York, NY 10001, USA</p>
            </div>
          </div>
          <div class="flex gap-6">
            <a href="#" class="text-cream/50 hover:text-cream transition">
              <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" />
              </svg>
            </a>
            <a href="#" class="text-cream/50 hover:text-cream transition">
              <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z" />
              </svg>
            </a>
            <a href="#" class="text-cream/50 hover:text-cream transition">
              <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" />
              </svg>
            </a>
            <a href="#" class="text-cream/50 hover:text-cream transition">
              <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                <path d="M9 8h-3v4h3v12h5v-12h3.642l.358-4h-4v-1.667c0-.955.192-1.333 1.115-1.333h2.885v-5h-3.808c-3.596 0-5.192 1.583-5.192 4.615v3.385z" />
              </svg>
            </a>
          </div>
        </div>
        <div class="mt-12 pt-8 border-t border-white/5 text-center text-cream/40 text-sm">
          © 2025 Jovexa. All rights reserved.
        </div>
      </div>
    </footer>
    """
  end
end
