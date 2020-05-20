require 'oystercard'

describe Oystercard do
  subject  {Oystercard.new}
  let(:kingscross) { double('station') }
  let(:angel) { double("station") }
  it 'balance has default balance of 0' do
    expect(subject.instance_variable_get :@balance).to eq(0)
  end
  it 'initiates a injourney instance variable equal to false' do
    expect(subject.in_journey?).to eq(false)
  end

  context 'top up' do
    it 'tops up the card' do
      subject.top_up(20)
      expect(subject.top_up(10)).to eq(30)
    end

    it 'raises an error if balance is more than 90' do
      expect{ subject.top_up(Oystercard::MAXBALANCE+1) }.to raise_error("Exceeded top up limit")
    end
  end

  context 'fare' do
     it 'deducts the fare from the balance' do
        expect{ subject.top_up(10) }.to change { subject.balance}. by (10)
     end
  end

  context 'barriers' do

    it 'does not allow card to touch in if below MINBALANCE' do
      expect{ Oystercard.new.touch_in(kingscross) }.to raise_error("Please top up before starting your journey")
    end

    it 'knows if a card is in_journey' do
      subject.top_up(10)
      subject.touch_in(kingscross)
      expect(subject).to be_in_journey
    end

    it 'knows if a card is being touched out' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'charges the fare upon arrival at destination' do
      subject.top_up(10)
      subject.touch_in(kingscross)
      expect { subject.touch_out(angel) }.to change { subject.balance }. by (-Oystercard::FARE)
    end

    it 'knows if a card has been touched out and interupts the journey' do
      subject.top_up(10)
      subject.touch_in(kingscross)
      subject.touch_out(angel)
     expect(subject).to_not be_in_journey
    end

    it 'knows if a card is currently in journey' do
      subject.top_up(10)
      subject.touch_in(kingscross)
     expect(subject).to be_in_journey
    end

    it 'knows if a card is not currently in use' do
      subject.top_up(10)
      subject.touch_in(kingscross)
      subject.touch_out(angel)
      expect(subject.in_journey?).to eq(false)
    end
  end

  context 'station' do
    it 'stores the enrty station whilst in transit' do
    subject.top_up(10)
    subject.touch_in(kingscross)
      expect(subject.journey).to include ( {entry_station: kingscross})
    #expect(card.entry_station).to eq(kingscross) 
    end

    it 'stores the data from completed journeys' do
      subject.top_up(10)
      subject.touch_in(kingscross)
      subject.touch_out(angel)
      expect(subject.journey).to include ( {entry_station: kingscross, exit_station: angel})
    end
  end
end
