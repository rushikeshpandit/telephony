defmodule Telephony.Server do
  use GenServer
  alias Telephony.Core

  def start_link(server_name) do
    GenServer.start_link(__MODULE__, [], name: server_name)
  end

  def init(subscribers), do: {:ok, subscribers}

  def handle_call({:create_subscriber, payload}, _, subcribers) do
    case Core.create_subscriber(subcribers, payload) do
      {:error, _} = err ->
        {:reply, err, subcribers}

      subcribers ->
        {:reply, subcribers, subcribers}
    end
  end

  def handle_call({:search_subscriber, phone_number}, _, subcribers) do
    subscriber = Core.search_subscriber(subcribers, phone_number)
    {:reply, subscriber, subcribers}
  end

  def handle_call({:make_call, phone_number, time_spent, date}, _, subscribers) do
    case Core.make_call(subscribers, phone_number, time_spent, date) do
      {:error, _} = err ->
        {:reply, err, subscribers}

      {subcribers, subscriber} ->
        {:reply, subscriber, subcribers}
    end
  end

  def handle_call({:print_invoice, phone_number, year, month}, _, subscribers) do
    invoice = Core.print_invoice(subscribers, phone_number, year, month)
    {:reply, invoice, subscribers}
  end

  def handle_call({:print_invoices, year, month}, _, subscribers) do
    invoice = Core.print_invoices(subscribers, year, month)
    {:reply, invoice, subscribers}
  end

  def handle_cast({:make_recharge, phone_number, value, date}, subscribers) do
    case Core.make_recharge(subscribers, phone_number, value, date) do
      {:error, _} ->
        {:noreply, subscribers}

      {subcribers, _} ->
        {:noreply, subcribers}
    end
  end
end
