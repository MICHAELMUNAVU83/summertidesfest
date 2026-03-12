defmodule SummertidesfestWeb.HomeLive.Index do
  use SummertidesfestWeb, :live_view

  @artists [
    %{name: "Grauchi", image: "/artists/GRAUCHI.jpeg"},
    %{name: "Sir M", image: "/artists/sirm.jpg"},
    %{name: "Etana", image: "/artists/etana.jpg"},
    %{name: "Joe Mfalme", image: "/artists/JOE MFALME.jpeg"},
    %{name: "G Money", image: "/artists/G MONEY.jpeg"},
    %{name: "Kaneda", image: "/artists/KANEDA.jpeg"},
    %{name: "Mista C", image: "/artists/mista.jpg"},
    %{name: "MC Gogo", image: "/artists/gogo.jpg"},
    %{name: "Dj Daffy", image: "/artists/daffy.jpg"},
    %{name: "Chipi", image: "/artists/chipi.jpg"},
    %{name: "Andy Young", image: "/artists/andyyoung.jpg"},
    %{name: "DJ Kace", image: "/artists/kace.jpg"},
    %{name: "Vansss", image: "/artists/vansss.jpg"},
    %{name: "KU5", image: "/artists/KU5.jpeg"},
    %{name: "Suraj", image: "/artists/SURAJ.jpeg"},
    %{name: "Ballo", image: "/artists/BALLO.jpg"},
    %{name: "Malonza", image: "/artists/MALONZA.jpeg"},
    %{name: "Ms Bune", image: "/artists/MS BUNE.jpeg"},
    %{name: "Euggy", image: "/artists/EUGGY.jpeg"},
    %{name: "Junior Petes", image: "/artists/JUNIOR PETES.jpeg"},
    %{name: "Santa", image: "/artists/SANTA.jpeg"},
    %{name: "Teekay", image: "/artists/TEEKAY.jpeg"},
    %{name: "Ms Mike", image: "/artists/MS MIKA.jpeg"},
    %{name: "TM", image: "/artists/TM.jpeg"}
  ]

  @gallery_images [
    "/images/pic.jpg",
    "/images/pic2.jpg",
    "/images/pic4.jpg",
    "/images/pic5.jpg",
    "/images/pic6.jpg",
    "/images/pic7.jpg",
    "/images/pic9.jpg"
  ]

  @hero_slides ["/images/pic.jpg", "/images/pic2.jpg", "/images/pic5.jpg", "/images/pic6.jpg", "/images/pic7.jpg"]

  @schedule %{
    "day1" => [%{name: "TBA"}],
    "day2" => [%{name: "TBA"}],
    "day3" => [%{name: "TBA"}]
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Summer Tides: Summer Love — July 2–4, 2026 | Lost Beach Club, Malindi")
     |> assign(:artists, @artists)
     |> assign(:gallery_images, @gallery_images)
     |> assign(:hero_slides, @hero_slides)
     |> assign(:schedule, @schedule)
     |> assign(:selected_day, "day1")}
  end

  @impl true
  def handle_event("select_day", %{"day" => day}, socket) do
    {:noreply, assign(socket, :selected_day, day)}
  end
end
