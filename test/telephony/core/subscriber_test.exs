defmodule Telephony.Core.SubscriberTest do
  alias Telephony.Core.Subscriber
  use ExUnit.Case

  test "create subscriber" do
    # given
    payload = %{
      name: "Rushikesh",
      phone_no: "123"
    }

    # when
    result = Subscriber.new(payload)

    # then
    expect = %Subscriber{
      name: "Rushikesh",
      phone_no: "123",
      subscriber_type: :prepaid
    }

    assert expect == result
  end
end
