defmodule MpesaWeb.MpesaController do
  use MpesaWeb, :controller

  require Logger
  # # Handles the callback data
  # def handle_callback(conn, %{"Body" => %{"stkCallback" => stk_callback}} = _params) do
  #   # Extract the result code

  #   Logger.info("STK Callback: #{inspect(stk_callback)}")
  #   result_code = Map.get(stk_callback, "ResultCode")

  #   if result_code != 0 do
  #     # Handle the failed transaction
  #     error_message = Map.get(stk_callback, "ResultDesc")
  #     response_data = %{"ResultCode" => result_code, "ResultDesc" => error_message}

  #     # Respond to M-Pesa with the error details
  #     conn
  #     |> put_status(:ok)
  #     |> json(response_data)
  #   else
  #     # Handle the successful transaction
  #     callback_metadata = Map.get(stk_callback, "CallbackMetadata", %{})

  #     # Parse the metadata
  #     amount = find_item(callback_metadata, "Amount")
  #     mpesa_code = find_item(callback_metadata, "MpesaReceiptNumber")
  #     phone_number = find_item(callback_metadata, "PhoneNumber")

  #     # Example: Save to the database (replace `save_transaction/3` with your implementation)
  #     save_transaction(amount, mpesa_code, phone_number)

  #     # Respond with success
  #     conn
  #     |> put_status(:ok)
  #     |> json(%{"status" => "success"})
  #   end
  # end

  def handle_callback(conn, %{
        "CheckoutRequestID" => checkout_request_id,
        "CustomerMessage" => customer_message,
        "MerchantRequestID" => merchant_request_id,
        "ResponseCode" => response_code,
        "ResponseDescription" => response_description
      }) do
    # Process the parameters as needed
    IO.inspect(
      %{
        checkout_request_id: checkout_request_id,
        customer_message: customer_message,
        merchant_request_id: merchant_request_id,
        response_code: response_code,
        response_description: response_description
      },
      label: "Received Callback"
    )

    json(conn, %{"status" => "success"})
  end

  def handle_callback(conn, %{
        "Body" => %{
          "stkCallback" => %{
            "CheckoutRequestID" => checkout_request_id,
            "MerchantRequestID" => merchantRequestID,
            "ResultCode" => resultCode,
            "ResultDesc" => resultDesc
          }
        }
      }) do
    json(conn, %{"status" => "error", "message" => "Invalid payload"})
  end

  # Handles the callback data
  def handle_callback(conn, %{"Body" => %{"stkCallback" => stk_callback}} = _params) do
    # Extract the result code
    IO.inspect(stk_callback, label: "STK Callback")
    json(conn, %{"status" => "success"})
  end

  def handle_callback(conn, params) do
    IO.inspect(params, label: "Unhandled Callback Parameters")
    json(conn, %{"status" => "error", "message" => "Invalid payload"})
  end

  # Helper function to extract an item by name
  defp find_item(%{"Item" => items}, name) do
    items
    |> Enum.find(fn %{"Name" => n} -> n == name end)
    |> Map.get("Value")
  end

  # Mock function for saving the transaction (replace with actual logic)
  defp save_transaction(amount, mpesa_code, phone_number) do
    IO.puts("Amount: #{amount}, Code: #{mpesa_code}, Phone: #{phone_number}")
    :ok
  end
end
