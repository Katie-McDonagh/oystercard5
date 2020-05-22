require_relative 'station'
require_relative 'oystercard'

class Journey

  attr_reader :current_journey, :entry_station 

  PENALTY = 6
  NORMALFARE = 1

  def initialize(entry_station = nil)
   @entry_station = entry_station
    @current_journey = []
  end

  def start_journey#(station) # should be connected with touch_in method
    station = @entry_station # untested line
    @current_journey.push({entry_station: station})
  end

  def end_journey(station) # should be connected with touch_out method
    @current_journey[-1].store(:exit_station, station) # if entry station is supplied
    # other wise put it in its own hash.
    p @current_journey
  end

  def journey_check
    return false if @current_journey.empty? # completed journey
    @current_journey.last.length == 1 # uncompleted journery
  end

  def fare
    return PENALTY if @current_journey.last.length == 1
    NORMALFARE
  end
end
