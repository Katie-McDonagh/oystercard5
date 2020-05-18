require 'oystercard'

describe Oystercard do
  subject = Oystercard.new
  it 'balance has default balance of 0' do
    expect(subject.instance_variable_get :@balance).to eq(0)
  end
  it 'respond to top_up method' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end
  it 'respond to fare method' do
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
  end
end
