defmodule SummertidesfestWeb.PaymentController do
  use SummertidesfestWeb, :controller

  alias Summertidesfest.{Paystack, Shop}

  def callback(conn, %{"reference" => reference}) do
    with {:ok, _data} <- Paystack.verify(reference),
         {:ok, order} <- Shop.get_order_by_reference(reference),
         {:ok, _updated} <- Shop.update_order_status(order, "processing") do
      conn
      |> put_flash(:info, "Payment successful! Order ##{reference} confirmed.")
      |> redirect(to: "/payment/success?ref=#{reference}")
    else
      {:error, :not_found} ->
        conn
        |> put_flash(:error, "Order not found.")
        |> redirect(to: "/merch")

      {:error, reason} ->
        conn
        |> put_flash(:error, "Payment verification failed: #{reason}")
        |> redirect(to: "/merch")
    end
  end

  def success(conn, %{"ref" => reference}) do
    case Shop.get_order_by_reference(reference) do
      {:ok, order} ->
        render(conn, :success, order: order)

      {:error, _} ->
        redirect(conn, to: "/merch")
    end
  end
end
