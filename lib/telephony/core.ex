defmodule Telephony.Core do
  alias Telephony.Core.Subscriber
  @subscriber_types [:prepaid, :postpaid]

  def create_subscriber(subscribers, %{subscriber_type: subscriber_type} = payload)
      when subscriber_type in @subscriber_types do
    case Enum.find(subscribers, &(&1.phone_no == payload.phone_no)) do
      nil ->
        subscriber = Subscriber.new(payload)
        subscribers ++ [subscriber]

      _ ->
        {:error, "subscriber already exists"}
    end
  end

  def create_subscriber(_subscribers, _payload) do
    {:error, "invalid subscriber type"}
  end
end
