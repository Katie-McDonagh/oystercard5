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

  def start_journey(station) # should be connected with touch_in method
    @current_journey.push({:entry_station => station, :exit_station => nil})
  end

  def end_journey(station) # should be connected with touch_out method
    if @entry_station
      @current_journey[-1].store(:exit_station, station)
    else
      @current_journey.push({:entry_station => nil, :exit_station => station})
    end
  end

  def complete?
    return false if @current_journey[-1][:exit_station] == nil || @current_journey[-1][:entry_station] == nil
  end

  def fare
    return PENALTY if !complete?
    NORMALFARE
  end
end
