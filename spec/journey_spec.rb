require 'journey'

describe Journey do
  subject { Journey.new }

  let(:kingscross) { double('station') }
  let(:angel) { double('station') }

  it 'starts a journey by adding entry_station to instance Variable' do
    subject.start_journey(angel)
    expect(subject.current_journey).to include({entry_station: angel})
  end

  it 'ends a journey by adding exit_station to instance varible' do
    subject.start_journey(angel)
    subject.end_journey(kingscross)
    expect(subject.current_journey).to include({entry_station: angel, exit_station: kingscross})
  end

  it 'should return if in a journey' do
    subject.start_journey(angel)
    expect(subject.journey_check).to be true
  end

  context 'fare' do 
  # it 'should know fare exists' do 
  #   expect(subject).to respond_to(:fare)
  # end

  # it 'has a penalty fare by default' do
  #   expect(subject.fare).to eq Journey::PENALTY_FARE
  # end
end
end
