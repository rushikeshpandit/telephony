defmodule Telephony.Core do
  alias Telephony.Core.Subscriber

  def create_subscriber(subscribers, payload) do
    subscriber = Subscriber.new(payload)
    subscribers ++ [subscriber]
  end
end
