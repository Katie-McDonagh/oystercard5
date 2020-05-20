require 'oystercard'

describe Oystercard do
  subject = Oystercard.new
  let(:kingscross) { double('station') }
  let(:angel) { double("station") }
  it 'balance has default balance of 0' do
    expect(subject.instance_variable_get :@balance).to eq(0)
  end
  it 'initiates a injourney instance variable equal to false' do
    expect(subject.instance_variable_get :@injourney).to eq(false)
  end
  it 'respond to top_up method' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end
  xit 'respond to fare method' do
    expect(subject).to respond_to(:fare)
  end

  context 'top up' do
    it 'tops up the card' do
      test_variable = Oystercard.new
      test_variable.top_up(20)
      expect(test_variable.top_up(10)).to eq(30)
    end

    it 'raises an error if balance is more than 90' do
      expect{ subject.top_up(91) }.to raise_error("Exceeded top up limit")
    end
  end

  context 'fare' do
     it 'deducts the fare from the balance' do
       test_variable = Oystercard.new
       test_variable.top_up(10)
       expect(test_variable.fare).to eq(9)
     end
  end

  context 'barriers' do
    it 'knows if a card is being touched in' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'does not allow card to touch in if below MINBALANCE' do
      expect{ subject.touch_in(kingscross) }.to raise_error("Please top up before starting your jounrey")
    end

    it 'knows if a card is in_journey' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in(kingscross)
      expect(card).to be_in_journey
    end

    it 'knows if a card is being touched out' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'charges the fare upon arrival at destination' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in(kingscross)
      expect { card.touch_out(angel) }.to change { card.balance }. by (-Oystercard::FARE)
    end

    it 'knows if a card has been touched out and interupts the journey' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in(kingscross)
      card.touch_out(angel)
     expect(card).to_not be_in_journey
    end

    it 'knows if a card is currently in journey' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in(kingscross)
     expect(card).to be_in_journey
    end

    it 'knows if a card is not currently in use' do
      card = Oystercard.new
      card.touch_out(angel)
      expect(card.in_journey?).to eq(false)
    end
  end

  context 'station' do
    it 'stores the enrty station whilst in transit' do
    card = Oystercard.new
    card.top_up(10)
    card.touch_in(kingscross)
    expect(card.entry_station).to eq(kingscross) 
    end

    it 'resets the entry station after touch out' do
      card = Oystercard.new
      card.top_up(1)
      card.touch_in(kingscross)
      card.touch_out(angel) 
      expect(card.entry_station).to be_nil
    end

    it 'stores the data from completed journeys' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in(kingscross)
      card.touch_out(angel)
      expect(card.journey).to include ( {entry_station: kingscross, exit_station: angel})
    end
  end
end
