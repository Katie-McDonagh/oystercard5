require 'station'

class Journey

  attr_reader :current_journey

  def initialize
    @current_journey = []
  end

  def start_journey(station)
    @current_journey.push({entry_station: station})
  end

  def end_journey(station)
    @current_journey[-1].store(:exit_station, station) 
  end

  def journey_check
    return false if @current_journey.empty?
    @current_journey.last.length == 1
  end

  def charge 
    @current_journey[-1][:entry_station].zone 
  end

end
