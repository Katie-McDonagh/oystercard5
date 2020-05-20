class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone =zone
  end

  # def initialize
  #   @list_of_stations = [{name: "kingscross", zone: 1}, {name: "angel", zone: 2}]
  # end

end
