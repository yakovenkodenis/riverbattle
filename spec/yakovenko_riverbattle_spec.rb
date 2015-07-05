require 'spec_helper'

describe YakovenkoRiverbattle do

  subject(:game) 	{ Game.new }

  it 'has a version number' do
    expect(YakovenkoRiverbattle::VERSION).not_to be nil
  end

  it 'has a start method in the Game class' do
    expect(Game.method_defined? :start).to be_truthy
  end

  it 'includes the Symbols module in the Game class' do
    expect(Game.included_modules).to include(Symbols)
  end

end
