class Oystercard

  attr_reader :balance, :injourney

  MAXBALANCE = 90
  FARE = 1

  def initialize
    @balance = 0
    @injourney = false


  def top_up(money)

    if (@balance + money) > MAXBALANCE

      raise "Exceeded top up limit"
    end
      @balance = @balance + money
  end

  def fare
    @balance -= FARE
  end

  def touch_in
  end

  def touch_out
  end

  def in_journey?
  end

end
end
