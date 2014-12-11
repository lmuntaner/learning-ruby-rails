require 'card'
require 'hand'

describe Hand do
  let(:card_one) { Card.new(:spades, :nine) }
  let(:card_two) { Card.new(:spades, :eight) }
  let(:deck) { double("Deck") }
  let(:pile) { double("DiscardPile") }
  
  describe "::deal_from" do
    it "deals a hand of two cards" do
      deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :four),
        Card.new(:spades, :five),
        Card.new(:spades, :six),
        Card.new(:spades, :seven),
        Card.new(:spades, :eight),
        Card.new(:spades, :nine)
      ]

      deck = double("deck")
      allow(deck).to receive(:take).with(8) { deck_cards }
      
      hand = Hand.deal_from(deck)

      expect(hand.cards.count).to eq(8)
    end
  end

  describe "#draw" do
    it "draws a card from deck" do
      allow(deck).to receive(:take).with(1) { [card_one] }

      hand = Hand.new([], deck)
      hand.draw

      expect(hand.cards.count).to eq(1)
    end
  end

  describe "#discard" do
    it "removes a card from hand" do
      hand = Hand.new([
          Card.new(:spades, :nine),
          Card.new(:spades, :ten)
        ], deck)
      
      hand.discard(pile, 0)
      allow(pile).to receive(:discard).with(hand[0]) {  }
      expect(hand.count).to eq(1)
    end

    it "doesn't allow an invalid card to be played" do
      hand = Hand.new([
          Card.new(:spades, :ace),
          Card.new(:spades, :ten)
        ], deck)
      allow(pile).to receive(:discard).with(hand[0]) do
        raise "must play :hearts, :ten, or a crazy 8!"
      end

      expect do
        hand.discard(pile, 0)
      end.to raise_error("must play :hearts, :ten, or a crazy 8!")
    end
  end

  describe "#can_play" do
    let(:hand) do
      Hand.new([Card.new(:spades, :ten), Card.new(:spades, :three)], deck)
    end

    it "returns true if hand contains playable card" do
      allow(pile).to receive(:last_value) { :ten }
      
      expect(hand.can_play?(pile)).to be(true)
    end
    
    it "returns false if hand contains no playable card" do
      allow(pile).to receive(:last_value) { :ace }
      allow(pile).to receive(:last_suit) { :king }
      
      expect(hand.can_play?(pile)).to be(false)
    end
    
    it "returns true if hand contains an eight" do
      hand1 = Hand.new([
        Card.new(:spades, :eight)
      ], deck)
      
      expect(hand1.can_play?(pile)).to be(true)
    end
  end
end
