require 'journey'

class Oystercard

  attr_reader :balance, :journey

  MAXBALANCE = 90
  MINBALANCE = 1
  FARE = 1

  def initialize
    @balance = 0
    @journey = []
end

  def top_up(money)

    if (@balance + money) > MAXBALANCE

      raise "Exceeded top up limit"
    end
      @balance += money
  end

  def touch_in(station)

      fail "Please top up before starting your journey" if @balance < MINBALANCE
      @current_journey = Journey.new(station)
      #
      # @current_journey.start_journey(station)

      #@journey.push({entry_station: station})
  end

  def touch_out(station)
    @current_journey.end_journey(station)
    @journey.push(@current_journey.current_journey)
    deduct
  end

  def in_journey?
    @current_journey.journey_check
  end

  private
  def deduct
    @balance -= FARE
  end
end
