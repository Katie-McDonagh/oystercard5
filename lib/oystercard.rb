class Oystercard

  attr_reader :balance, :injourney, :entry_station, :journey

  MAXBALANCE = 90
  MINBALANCE = 1
  FARE = 1

  def initialize
    @balance = 0
    @injourney = false
    @entry_station
    @journey = []
end

  def top_up(money)

    if (@balance + money) > MAXBALANCE

      raise "Exceeded top up limit"
    end
      @balance += money
  end

  def fare
    @balance -= FARE
  end

  def touch_in(station)

      fail "Please top up before starting your jounrey" if @balance < MINBALANCE

    @injourney = true
    @entry_station = station
  end

  def touch_out(station)
    fare 
    @journey.push({entry_station: @entry_station, exit_station: station})
    @injourney = false
    @entry_station = nil
  end

  def in_journey?
    @injourney
  end

end

