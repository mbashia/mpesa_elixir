defmodule Mpesa.StkForm do
  import Ecto.Changeset

  @types %{
    Phone_number: :string,
    amount: :integer
  }

  def changeset(data, params) do
    {data, @types}
    |> cast(params, Map.keys(@types))
    |> validate_required([:Phone_number, :amount])
    |> validate_format(:Phone_number, ~r/^2547\d{8}$/,
      message: "Phone number must be in the format 2547XXXXXXXX"
    )
    |> validate_number(:amount, greater_than: 0, message: "Amount must be greater than zero")
  end
end
