require 'spec_helper'

describe YakovenkoRiverbattle do

  it 'has a version number' do
    expect(YakovenkoRiverbattle::VERSION).not_to be nil
  end

    context 'Game class' do

        it 'has a start method in the Game class' do
            expect(Game.method_defined? :start).to be_truthy
        end

        it 'includes the Symbols module in the Game class' do
            expect(Game.included_modules).to include(Symbols)
        end

    end


    context 'Move class' do

        it 'contains :hit attribute' do
            expect(Move.method_defined? :hit).to be_truthy
        end

        it 'contains :index attribute' do
            expect(Move.method_defined? :index).to be_truthy
        end

        it 'accepts 2 arguments when initialized' do
            expect(Move.instance_method(:initialize).arity).to eq(2)
        end
 
    end

    context 'Human class' do

        it 'contains 9 methods' do
            expect(Player.instance_methods.size).to eq(9)
        end

    end

end
