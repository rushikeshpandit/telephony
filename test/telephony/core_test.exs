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

    payload = %{
      name: "Rushikesh",
      phone_no: "123",
      subscriber_type: :prepaid
    }

    %{subscribers: subscribers, payload: payload}
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

  test "show error when subscriber already exists", %{
    subscribers: subscribers,
    payload: payload
  } do
    result = Core.create_subscriber(subscribers, payload)
    assert {:error, "subscriber already exists"} == result
  end

  test "show error when subscriber type does not exists", %{
    payload: payload
  } do
    payload = Map.put(payload, :subscriber_type, :partpay)

    result = Core.create_subscriber([], payload)
    assert {:error, "invalid subscriber type"} == result
  end
end
