defmodule MpesaWeb.Stklive.Index do
  @moduledoc """
  The `MpesaWeb.Stklive.Index` LiveView is used to test the STK push functionality for M-Pesa integration.

  This LiveView handles the rendering of the form and processes the events related to 
  M-Pesa STK push interactions, including validation and submission of parameters.


  """
  use MpesaWeb, :live_view

  alias Mpesa.StkForm

  require Logger

  def mount(_params, _session, socket) do
    # Create an empty changeset for initializing the form
    initial_changeset = StkForm.changeset(%{}, %{})

    {:ok,
     socket
     |> assign(:form, to_form(initial_changeset, as: "stk_form"))}
  end

  def handle_event(
        "validate",
        %{"stk_form" => %{"Phone_number" => phone_number, "amount" => amount}} = params,
        socket
      ) do
    # Use a plain map as data
    IO.inspect(params, label: "Inspecting params")
    data = %{}

    # Build the changeset
    changeset = StkForm.changeset(data, %{:Phone_number => phone_number, :amount => amount})
    IO.inspect(changeset, label: "Inspecting changeset")

    {:noreply, assign(socket, form: to_form(changeset, action: :validate, as: "stk_form"))}
  end
end


## test- if phone number is valid
## test- if amount is greater than 0
## 
## test- if phone number is invalid

## validate phone number
