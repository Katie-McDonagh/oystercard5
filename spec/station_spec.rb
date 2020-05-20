require 'station'

describe Station do
  subject { Station.new("angel", 2) }

  it 'will have the name set to first argument' do
    expect(subject.name).to eq("angel")
  end

  it 'will have the zone set to the second argument' do
    expect(subject.zone).to eq(2)
  end

  # it 'creates an instance varible of array of stations' do
  #   expect(subject.list_of_stations).to eq([{name: "kingscross", zone: 1}, {name: "angel", zone: 2}])
  # end

end
