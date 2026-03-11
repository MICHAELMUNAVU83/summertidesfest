defmodule SummertidesfestWeb.FaqsLive.Index do
  use SummertidesfestWeb, :live_view

  @faqs [
    %{
      id: 0,
      question: "When is Summer Tides 2026?",
      answer: "Summer Tides: Summer Love takes place July 2nd–4th, 2026 — three full days of music, beach vibes, and unforgettable moments."
    },
    %{
      id: 1,
      question: "Where is the festival located?",
      answer: "The 2026 edition is at our brand new home — Lost Beach Club, Malindi, Kenya. Located on the stunning Malindi Beach, approximately 120km north of Mombasa along Kenya's beautiful coastline."
    },
    %{
      id: 2,
      question: "How do I purchase a ticket?",
      answer: "Tickets are available at summertidesfestival.hustlesasa.shop. Tier 2 Weekend Passes are currently on sale at KSH 5,000 and grant access to the festival for all three days. Simply visit the site, select your ticket, and complete your purchase securely online."
    },
    %{
      id: 3,
      question: "What time does the festival start and end each day?",
      answer: "The festival kicks off at 4:00 PM each day and runs through to 7:00 AM the following morning. Come early, stay late — there's music all night long."
    },
    %{
      id: 4,
      question: "Are there age restrictions for attending?",
      answer: "Yes — Summer Tides is strictly 18+ and ID will be required at the gate. No exceptions. Please carry a valid government-issued photo ID (National ID, Passport, or Driver's License)."
    },
    %{
      id: 5,
      question: "Can I bring my own food and drinks?",
      answer: "Outside food and drinks are not permitted at the venue. We have a curated food village with a wide variety of local Swahili cuisine, international bites, fresh seafood, and fully stocked beach bars operating throughout the festival."
    },
    %{
      id: 6,
      question: "How do I get to Lost Beach Club, Malindi?",
      answer: "You can fly directly into Malindi Airport (MYD) — there are daily flights from Nairobi. Alternatively, fly into Mombasa (MBA) and take a 2-hour drive north. Official festival shuttle services will also be available from Mombasa. More transport details will be announced closer to the event."
    },
    %{
      id: 7,
      question: "Where can I stay during the festival?",
      answer: "Our official Airbnb partner Sands of the East offers exclusive accommodation at festival rates. We also recommend booking hotels and guesthouses in Malindi early as spaces fill up fast. More accommodation partners will be announced soon."
    },
    %{
      id: 8,
      question: "Is the festival rain or shine?",
      answer: "Yes — Summer Tides is a rain-or-shine event. The festival will proceed regardless of weather conditions and no refunds will be issued due to weather. July is generally sunny on the Kenyan coast, but we recommend bringing a light layer for the late-night sessions."
    },
    %{
      id: 9,
      question: "What should I bring to the festival?",
      answer: "Bring your valid ID and ticket (printed or digital), sunscreen, sunglasses, a hat, comfortable footwear (flip-flops recommended), a beach towel, reusable water bottle, and cash or M-Pesa for vendors. Do not bring glass bottles, outside beverages, weapons, or illegal substances."
    }
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "FAQs — Summer Tides: Summer Love 2026")
     |> assign(:faqs, @faqs)
     |> assign(:active_faq, nil)}
  end

  @impl true
  def handle_event("toggle_faq", %{"id" => id}, socket) do
    id = String.to_integer(id)
    active = if socket.assigns.active_faq == id, do: nil, else: id
    {:noreply, assign(socket, :active_faq, active)}
  end
end
