defmodule Subscriber.SubscriberTest do
  alias Subscriber.Subscriber
  use ExUnit.Case

  test "create subscriber" do
    # given
    payload = %{
      name: "Rushikesh",
      id: "123",
      phone_no: "123"
    }

    # when
    result = Subscriber.new(payload)

    # then
    expect = %Subscriber{
      name: "Rushikesh",
      id: "123",
      phone_no: "123",
      subscriber_type: :prepaid
    }

    assert expect == result
  end
end
