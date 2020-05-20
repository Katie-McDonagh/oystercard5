require 'journey'

class Oystercard

  attr_reader :balance

  MAXBALANCE = 90
  MINBALANCE = 1
  FARE = 1
  PENALTYCHARGE = 6

  def initialize
    @balance = 0
    @current_journey = Journey.new
end

  def top_up(money)

    if (@balance + money) > MAXBALANCE

      raise "Exceeded top up limit"
    end
      @balance += money
  end

  def touch_in(station)

      fail "Please top up before starting your journey" if @balance < MINBALANCE

       deduct(PENALTYCHARGE) if in_journey? 

       @current_journey.start_journey(station)
  end

  def touch_out(station)
    @current_journey.end_journey(station)
    deduct(FARE)
  end

  def in_journey?
    @current_journey.journey_check
  end

  private
  def deduct(cost)
    @balance -= cost
  end
end
