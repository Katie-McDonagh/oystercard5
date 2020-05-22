require_relative 'station'
require_relative 'oystercard'

class Journey

  attr_reader :current_journey, :entry_station 

  PENALTY = 6
  NORMALFARE = 1

  def initialize(entry_station = nil, exit_station = nil)
   @entry_station = entry_station
   @exit_station = exit_station
    @current_journey = []
  end

  def start_journey#(station) # should be connected with touch_in method
    station = @entry_station # untested line
    @current_journey.push({:entry_station => station, :exit_station => nil})
  end

  def end_journey # should be connected with touch_out method
    station = @exit_station
    @current_journey[-1].store(:exit_station, station) # if entry station is supplied
    # other wise put it in its own hash.
    p @current_journey
  end

  def journey_check
    return false if @current_journey.empty? # completed journey
    @current_journey.last.length == 1 # uncompleted journery
  end

  def fare
    return PENALTY if @current_journey[-1][:exit_station] == nil || @current_journey[-1][:entry_station] == nil
    NORMALFARE
  end
end
