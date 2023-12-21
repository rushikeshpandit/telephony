defmodule TelephonyTest do
  use ExUnit.Case

  test "create subscriber" do
    payload = %{full_name: "Rushikesh", phone_number: "123", type: :prepaid}

    assert Telephony.create_subscriber(payload) == [
             %Telephony.Core.Subscriber{
               full_name: "Rushikesh",
               phone_number: "123",
               type: %Telephony.Core.Prepaid{credits: 0, recharges: []},
               calls: []
             }
           ]
  end
end
