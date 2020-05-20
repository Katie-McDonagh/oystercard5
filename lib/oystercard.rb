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

      @journey.push({entry_station: station})
  end

  def touch_out(station)
    fare
    @journey[-1].store(:exit_station, station)
  end

  def in_journey?
    return false if @journey.empty?
    @journey.last.length == 1
  end

  private
  def fare
    @balance -= FARE
  end
end
