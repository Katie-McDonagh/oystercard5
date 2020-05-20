class Journey

  attr_reader :current_journey

  def initialize(station)
    @current_journey = {entry_station: station}
  end

  def end_journey(station)
    @current_journey.store(:exit_station, station)
  end

  def journey_check
    return false if @current_journey.empty?
    @current_journey.length == 1
  end

end
