require 'oystercard'

describe Oystercard do
  subject  {Oystercard.new}
  let(:kingscross) { double('station') }
  let(:angel) { double("station") }

  it 'balance has default balance of 0' do
    expect(subject.instance_variable_get :@balance).to eq(0)
  end
  it 'initiates a injourney instance variable equal to false' do
    subject.top_up(10)
    subject.touch_in(angel)
    subject.touch_out(kingscross)
    expect(subject.in_journey?).to eq(false)
  end

  context 'top up' do

    before do
      subject.top_up(20)
    end

    it 'tops up the card' do
      expect(subject.top_up(10)).to eq(30)
    end

    it 'raises an error if balance is more than 90' do
      expect{ subject.top_up(Oystercard::MAXBALANCE) }.to raise_error("Exceeded top up limit")
    end
  end

  context 'fare' do
     it 'deducts the fare from the balance' do
        expect{ subject.top_up(10) }.to change { subject.balance}. by (10)
     end
  end

  it 'does not allow card to touch in if below MINBALANCE' do
    expect{ Oystercard.new.touch_in(kingscross) }.to raise_error("Please top up before starting your journey")
  end

  context 'barriers' do

    before do
      subject.top_up(10)
      subject.touch_in(kingscross)
    end

    it 'knows if a card is in_journey' do
      expect(subject).to be_in_journey
    end

    it 'knows if a card is being touched out' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'charges the fare upon arrival at destination' do
      expect { subject.touch_out(angel) }.to change { subject.balance }. by (-Oystercard::FARE)
    end

    it 'knows if a card has been touched out and interupts the journey' do
      subject.touch_out(angel)
     expect(subject).to_not be_in_journey
    end

    it 'knows if a card is currently in journey' do
     expect(subject).to be_in_journey
    end

    it 'knows if a card is not currently in use' do
      subject.touch_out(angel)
      expect(subject.in_journey?).to eq(false)
    end

    it 'charges a customer if they touch in without touching out' do 
      expect { subject.touch_in(angel) }.to change { subject.balance }. by (-Oystercard::PENALTYCHARGE)
    end
  end
end
