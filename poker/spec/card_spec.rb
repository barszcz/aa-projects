require 'rspec'
require 'card'

describe 'Card' do

  describe '#initialize' do

    before (:each) do
      card = Card.new(:king, :hearts)
    end

    it 'has a readable value' do
      expect(card.value).to eq(:king)

    end

    it 'has a readable suit' do
      expect(card.suit).to eq(:hearts)
    end

    it 'cannot change its attributes' do
      expect do
        card.value = :deuce
      end.to raise_error(NoMethodError)
      expect do
        card.suit = :spades
      end.to raise_error(NoMethodError)
    end


  end


end
