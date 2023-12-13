defmodule Telephony.CoreTest do
  use ExUnit.Case
  alias Telephony.Core
  alias Telephony.Core.Subscriber

  setup do
    subscribers = [
      %Subscriber{
        name: "Rushikesh",
        phone_no: "123",
        subscriber_type: :prepaid
      }
    ]

    %{subscribers: subscribers}
  end

  test "create new subscriber" do
    subscribers = []

    payload = %{
      name: "Rushikesh",
      phone_no: "123"
    }

    result = Core.create_subscriber(subscribers, payload)

    expect = [
      %Subscriber{
        name: "Rushikesh",
        phone_no: "123",
        subscriber_type: :prepaid
      }
    ]

    assert expect == result
  end

  test "create new subscribers with array", %{subscribers: subscribers} do
    payload = %{
      name: "Rushi",
      phone_no: "1234",
      subscriber_type: :prepaid
    }

    result = Core.create_subscriber(subscribers, payload)

    expect = [
      %Subscriber{
        name: "Rushikesh",
        phone_no: "123",
        subscriber_type: :prepaid
      },
      %Subscriber{
        name: "Rushi",
        phone_no: "1234",
        subscriber_type: :prepaid
      }
    ]

    assert expect == result
  end
end
