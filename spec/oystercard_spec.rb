require 'oystercard'

describe Oystercard do
  it 'balance has default balance of 0' do
    expect(subject.instance_variable_get :@balance).to eq(0)
  end
  it 'respond to top_up method' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end
end
