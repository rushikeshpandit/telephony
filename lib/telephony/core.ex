defmodule Telephony.Core do
  alias Telephony.Core.Subscriber

  def create_subscriber(subscribers, %{subscriber_type: subscriber_type} = payload)
      when subscriber_type in [:prepaid, :postpaid] do
    case Enum.find(subscribers, &(&1.phone_no == payload.phone_no)) do
      nil ->
        subscriber = Subscriber.new(payload)
        subscribers ++ [subscriber]

      _ ->
        {:error, "subscriber already exists"}
    end
  end
end
