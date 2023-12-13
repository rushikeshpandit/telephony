defmodule Telephony.Core.SubscriberTest do
  alias Telephony.Core.{Subscriber, Prepaid, Postpaid}
  use ExUnit.Case

  test "create prepaid subscriber" do
    # given
    payload = %{
      name: "Rushikesh",
      phone_no: "123",
      subscriber_type: :prepaid
    }

    # when
    result = Subscriber.new(payload)

    # then
    expect = %Subscriber{
      name: "Rushikesh",
      phone_no: "123",
      subscriber_type: %Prepaid{credits: nil, recharges: []}
    }

    assert expect == result
  end

  test "create postpaid subscriber" do
    # given
    payload = %{
      name: "Rushikesh",
      phone_no: "123",
      subscriber_type: :postpaid
    }

    # when
    result = Subscriber.new(payload)

    # then
    expect = %Subscriber{
      name: "Rushikesh",
      phone_no: "123",
      subscriber_type: %Postpaid{spent: 0}
    }

    assert expect == result
  end
end
