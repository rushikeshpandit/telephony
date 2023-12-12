defmodule Subscriber.Subscriber do
  defstruct name: nil, id: nil, phone_no: nil, subscriber_type: :prepaid

  def new(payload) do
    %__MODULE__{
      name: payload.name,
      id: payload.id,
      phone_no: payload.phone_no,
      subscriber_type: :prepaid
    }
  end
end
