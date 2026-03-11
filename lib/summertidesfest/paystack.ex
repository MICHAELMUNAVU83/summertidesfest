defmodule Oasis.Paystack do
  @moduledoc "Paystack payment gateway integration."

  @api_base "https://api.paystack.co"

  defp headers do
    [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{api_key()}"}
    ]
  end

  @doc "Initialize a transaction. Returns {:ok, %{authorization_url, reference}} or {:error, reason}."
  def initialize(email, amount_naira, reference) do
    body = %{
      "reference" => reference,
      "email" => email,
      "amount" => round(amount_naira * 100),
      "callback_url" => callback_url()
    }

    case IO.inspect(
           Req.post("#{@api_base}/transaction/initialize",
             headers: headers(),
             json: body,
             retry: :transient,
             max_retries: 3,
             receive_timeout: 30_000
           )
         ) do
      {:ok, %{status: 200, body: %{"data" => data}}} ->
        {:ok,
         %{
           authorization_url: data["authorization_url"],
           reference: data["reference"]
         }}

      {:ok, %{body: body}} ->
        {:error, body["message"] || "Initialization failed"}

      {:error, reason} ->
        {:error, inspect(reason)}
    end
  end

  @doc "Verify a transaction reference. Returns {:ok, data} or {:error, reason}."
  def verify(reference) do
    case Req.get("#{@api_base}/transaction/verify/#{reference}",
           headers: headers(),
           receive_timeout: 30_000
         ) do
      {:ok, %{status: 200, body: %{"data" => data}}} ->
        if data["status"] == "success" do
          {:ok, data}
        else
          {:error, "Payment status: #{data["status"]}"}
        end

      {:ok, %{body: body}} ->
        {:error, body["message"] || "Verification failed"}

      {:error, reason} ->
        {:error, inspect(reason)}
    end
  end

  def callback_url do
    base = "https://summertidesfest.com"
    "#{base}/payment/callback"
  end

  defp api_key do
    "sk_test_7267bf7b9b38cd9798c6328f7e0b3cc5a264f4aa"
  end
end
