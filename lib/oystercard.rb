class Oystercard

  attr_reader :balance, :injourney

  MAXBALANCE = 90
  FARE = 1

  def initialize
    @balance = 0
    @injourney = false
end

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
    @injourney = true
  end

  def touch_out
    @injourney = false
  end

  def in_journey?
    if @injourney == true
      true
    else
      false
    end
  end

end
