defmodule SummertidesfestWeb.Admin.ProductsLive.Index do
  use SummertidesfestWeb, :live_view

  alias Summertidesfest.Shop
  alias Summertidesfest.Shop.Product

  @categories ["Tees", "Hoodies", "Hats", "Accessories", "Bottoms", "Other"]
  @all_sizes ["XS", "S", "M", "L", "XL", "XXL", "One Size"]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Products — Summer Tides Admin")
     |> assign(:products, Shop.list_products())
     |> assign(:categories, @categories)
     |> assign(:all_sizes, @all_sizes)
     |> assign(:filter_category, "All")
     |> assign(:sidebar_open, false)
     |> assign(:panel, nil)
     |> assign(:editing, nil)
     |> assign(:form_errors, %{})
     |> assign(:form, empty_form())
     |> allow_upload(:product_images,
          accept: ~w(.jpg .jpeg .png .webp),
          max_entries: 8,
          max_file_size: 10_000_000)}
  end

  @impl true
  def handle_event("toggle_sidebar", _params, socket) do
    {:noreply, assign(socket, :sidebar_open, !socket.assigns.sidebar_open)}
  end

  def handle_event("new_product", _params, socket) do
    {:noreply,
     socket
     |> assign(:panel, :form)
     |> assign(:editing, nil)
     |> assign(:form, empty_form())
     |> assign(:form_errors, %{})}
  end

  def handle_event("edit_product", %{"id" => id}, socket) do
    product = Shop.get_product!(String.to_integer(id))
    {:noreply,
     socket
     |> assign(:panel, :form)
     |> assign(:editing, product)
     |> assign(:form, product_to_form(product))
     |> assign(:form_errors, %{})}
  end

  def handle_event("close_panel", _params, socket) do
    {:noreply,
     socket
     |> assign(:panel, nil)
     |> cancel_all_uploads()}
  end

  def handle_event("filter_category", %{"category" => cat}, socket) do
    {:noreply, assign(socket, :filter_category, cat)}
  end

  # no-op — just lets LiveView track upload progress on phx-change
  def handle_event("validate_upload", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("update_field", %{"field" => field, "value" => value}, socket) do
    {:noreply, assign(socket, :form, Map.put(socket.assigns.form, field, value))}
  end

  def handle_event("toggle_size", %{"size" => size}, socket) do
    sizes = socket.assigns.form["sizes"] || []
    updated = if size in sizes, do: List.delete(sizes, size), else: [size | sizes]
    {:noreply, assign(socket, :form, Map.put(socket.assigns.form, "sizes", updated))}
  end

  # Cancel a specific upload entry
  def handle_event("cancel_upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :product_images, ref)}
  end

  # Remove an already-saved image URL
  def handle_event("remove_image", %{"index" => idx}, socket) do
    idx = String.to_integer(idx)
    images = List.delete_at(socket.assigns.form["images"] || [], idx)
    {:noreply, assign(socket, :form, Map.put(socket.assigns.form, "images", images))}
  end

  def handle_event("save_product", _params, socket) do
    form = socket.assigns.form
    errors = validate_form(form)

    if map_size(errors) > 0 do
      {:noreply, assign(socket, :form_errors, errors)}
    else
      # Consume and save uploaded files
      uploaded_paths =
        consume_uploaded_entries(socket, :product_images, fn %{path: tmp_path}, entry ->
          ext = Path.extname(entry.client_name) |> String.downcase()
          filename = "#{System.unique_integer([:positive])}#{ext}"
          uploads_dir = Path.join([Application.app_dir(:summertidesfest, "priv"), "static", "uploads", "products"])
          File.mkdir_p!(uploads_dir)
          dest = Path.join(uploads_dir, filename)
          File.cp!(tmp_path, dest)
          {:ok, "/uploads/products/#{filename}"}
        end)

      all_images = (form["images"] || []) ++ uploaded_paths

      attrs = %{
        name: form["name"],
        description: form["description"],
        price: parse_int(form["price"]),
        category: form["category"],
        sizes: form["sizes"] || [],
        images: all_images,
        in_stock: form["in_stock"] == "true",
        stock_count: parse_int(form["stock_count"])
      }

      result =
        case socket.assigns.editing do
          nil -> Shop.create_product(attrs)
          product -> Shop.update_product(product, attrs)
        end

      case result do
        {:ok, _product} ->
          {:noreply,
           socket
           |> assign(:products, Shop.list_products())
           |> assign(:panel, nil)
           |> put_flash(:info, if(socket.assigns.editing, do: "Product updated.", else: "Product created."))}

        {:error, changeset} ->
          errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, _} -> msg end)
          {:noreply, assign(socket, :form_errors, errors)}
      end
    end
  end

  def handle_event("delete_product", %{"id" => id}, socket) do
    product = Shop.get_product!(String.to_integer(id))
    {:ok, _} = Shop.delete_product(product)

    {:noreply,
     socket
     |> assign(:products, Shop.list_products())
     |> put_flash(:info, "Product deleted.")}
  end

  defp cancel_all_uploads(socket) do
    socket.assigns.uploads.product_images.entries
    |> Enum.reduce(socket, fn entry, acc ->
      cancel_upload(acc, :product_images, entry.ref)
    end)
  end

  defp empty_form do
    %{
      "name" => "",
      "description" => "",
      "price" => "",
      "category" => "Tees",
      "sizes" => [],
      "images" => [],
      "in_stock" => "true",
      "stock_count" => "0"
    }
  end

  defp product_to_form(%Product{} = p) do
    %{
      "name" => p.name || "",
      "description" => p.description || "",
      "price" => to_string(p.price || ""),
      "category" => p.category || "Tees",
      "sizes" => p.sizes || [],
      "images" => p.images || [],
      "in_stock" => to_string(p.in_stock),
      "stock_count" => to_string(p.stock_count || 0)
    }
  end

  defp validate_form(form) do
    %{}
    |> then(fn e -> if blank?(form["name"]), do: Map.put(e, "name", "Name is required"), else: e end)
    |> then(fn e -> if blank?(form["price"]), do: Map.put(e, "price", "Price is required"), else: e end)
    |> then(fn e ->
      case Integer.parse(form["price"] || "") do
        {n, ""} when n > 0 -> e
        _ -> if blank?(form["price"]), do: e, else: Map.put(e, "price", "Must be a positive number")
      end
    end)
    |> then(fn e -> if blank?(form["category"]), do: Map.put(e, "category", "Category is required"), else: e end)
  end

  def filter_products(products, "All"), do: products
  def filter_products(products, cat), do: Enum.filter(products, &(&1.category == cat))

  def friendly_error(:too_large), do: "File too large (max 10 MB)"
  def friendly_error(:too_many_files), do: "Too many files selected"
  def friendly_error(:not_accepted), do: "Invalid file type (JPG, PNG or WebP only)"
  def friendly_error(_), do: "Upload error"

  defp blank?(nil), do: true
  defp blank?(""), do: true
  defp blank?(_), do: false

  defp parse_int(nil), do: 0
  defp parse_int(""), do: 0
  defp parse_int(s) do
    case Integer.parse(to_string(s)) do
      {n, _} -> n
      :error -> 0
    end
  end
end
