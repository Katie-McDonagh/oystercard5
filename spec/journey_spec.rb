require 'journey'

describe Journey do
  subject { Journey.new(angel) }

  let(:kingscross) { double('station') }
  let(:angel) { double("station") }

  it 'starts a journey by adding entry_station to instance Variable' do
    expect(subject.current_journey).to eq({entry_station: angel})
  end

  it 'ends a journey by adding exit_station to instance varible' do
    subject.end_journey(kingscross)
    expect(subject.current_journey).to eq({entry_station: angel, exit_station: kingscross})
  end

  it 'should return if in a journey' do
    expect(subject.journey_check).to be true
  end

end
