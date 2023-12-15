defmodule Telephony.Core.PospaidTest do
  use ExUnit.Case
  alias Telephony.Core.{Call, Pospaid}

  setup do
    %{pospaid: %Pospaid{spent: 0}}
  end

  test "make a call", %{pospaid: pospaid} do
    time_spent = 2
    date = NaiveDateTime.utc_now()
    result = Subscriber.make_call(pospaid, time_spent, date)
    expect = {%Pospaid{spent: 2.08}, %Call{time_spent: 2, date: date}}
    assert expect == result
  end

  test "try to make a recharge" do
    pospaid = %Pospaid{spent: 90 * 1.04}

    assert {:error, "Pospaid can`t make a recharge!"} =
             Subscriber.make_recharge(pospaid, 100, Date.utc_today())
  end

  test "print invoice" do
    date = ~D[2022-11-01]
    last_month = ~D[2022-10-01]

    postpaid = %Pospaid{spent: 90 * 1.04}

    calls = [
      %Call{
        time_spent: 10,
        date: date
      },
      %Call{
        time_spent: 50,
        date: last_month
      },
      %Call{
        time_spent: 30,
        date: last_month
      }
    ]

    expect = %{
      value_spent: 80 * 1.04,
      calls: [
        %{
          time_spent: 50,
          value_spent: 50 * 1.04,
          date: last_month
        },
        %{
          time_spent: 30,
          value_spent: 30 * 1.04,
          date: last_month
        }
      ]
    }

    assert expect == Subscriber.print_invoice(postpaid, calls, 2022, 10)
  end
end
