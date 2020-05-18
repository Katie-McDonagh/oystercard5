class Oystercard

  attr_reader :balance

  MAXBALANCE = 90
  FARE = 1

  def initialize
    @balance = 0
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

end
