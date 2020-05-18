require 'oystercard'

describe Oystercard do
  it 'balance has default balance of 0' do
    expect(subject.instance_variable_get :@balance).to eq(0)
  end
  it 'respond to top_up method' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'tops up the card' do
    expect(subject.top_up(30)).to eq(30)
  end

#    it 'raises an error if balance is more than 90' do
#      expect(subject).to raise_error
# end
end
