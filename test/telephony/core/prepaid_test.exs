defmodule Telephony.Core.PrepaidTest do
  use ExUnit.Case
  alias Telephony.Core.{Call, Prepaid, Recharge}

  setup do
    prepaid = %Prepaid{credits: 10, recharges: []}
    prepaid_without_credits = %Prepaid{credits: 0, recharges: []}

    %{prepaid: prepaid, prepaid_without_credits: prepaid_without_credits}
  end

  test "make a call", %{prepaid: prepaid} do
    time_spent = 2
    date = NaiveDateTime.utc_now()
    result = Subscriber.make_call(prepaid, time_spent, date)

    prepaid_expect = %Prepaid{credits: 7.1, recharges: []}
    call_expect = %Call{time_spent: 2, date: date}
    expect = {prepaid_expect, call_expect}
    assert expect == result
  end

  test "try to make a call", %{prepaid_without_credits: prepaid} do
    time_spent = 2
    date = NaiveDateTime.utc_now()
    result = Subscriber.make_call(prepaid, time_spent, date)
    expect = {:error, "Subscriber does not have credits"}
    assert expect == result
  end

  test "make a recharge", %{prepaid: prepaid} do
    value = 100
    date = NaiveDateTime.utc_now()

    result = Subscriber.make_recharge(prepaid, value, date)

    prepaid_expected = %Prepaid{
      credits: 110,
      recharges: [
        %Recharge{value: 100, date: date}
      ]
    }

    assert prepaid_expected == result
  end

  test "print invoice" do
    date = ~D[2022-11-01]
    last_month = ~D[2022-10-01]

    subscriber = %Telephony.Core.Subscriber{
      full_name: "Rushikesh",
      phone_number: "123",
      type: %Prepaid{
        credits: 253.6,
        recharges: [
          %Recharge{value: 100, date: date},
          %Recharge{value: 100, date: last_month},
          %Recharge{value: 100, date: last_month}
        ]
      },
      calls: [
        %Call{
          time_spent: 2,
          date: date
        },
        %Call{
          time_spent: 10,
          date: last_month
        },
        %Call{
          time_spent: 20,
          date: last_month
        }
      ]
    }

    type = subscriber.type
    calls = subscriber.calls

    assert Subscriber.print_invoice(type, calls, 2022, 10) == %{
             calls: [
               %{
                 time_spent: 10,
                 value_spent: 14.5,
                 date: last_month
               },
               %{
                 time_spent: 20,
                 value_spent: 29.0,
                 date: last_month
               }
             ],
             recharges: [
               %Recharge{value: 100, date: last_month},
               %Recharge{value: 100, date: last_month}
             ],
             credits: 253.6
           }
  end
end
