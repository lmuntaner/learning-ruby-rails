require 'spec_helper'
require 'deck.rb'

describe Deck do
  subject(:deck) { Deck.new }
  
  it "starts with 52 cards" do
    new_deck = Deck.new
    expect(new_deck.count).to eq(52)
  end
  
  describe "#deal" do
    before(:each) do
      @new_cards = deck.deal(1)
    end
    
    it "deals cards" do
      expect(@new_cards.count).to eq(1)
      expect(@new_cards.first).to be_an_instance_of(Card)
    end
    
    it "removes cards from the stack" do
      expect(deck.count).to eq(51)
    end
  end
  
  describe "#shuffle!" do
    it "shuffles the deck" do
      place_holder = deck.cards.take(10)
      deck.shuffle!
      expect(deck.cards.take(10) == place_holder).to be false  
    end
  end
  
  describe '#reset!' do
    it "sets deck to original order" do
      place_holder = Deck.new
      deck.reset!

      expect(deck.cards == place_holder.cards).to be true
    end
  end
end