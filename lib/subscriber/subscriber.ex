defmodule Subscriber.Subscriber do
  defstruct name: nil, id: nil, phone_no: nil, subscriber_type: :prepaid

  def new(payload) do
    struct(__MODULE__, payload)
  end
end
