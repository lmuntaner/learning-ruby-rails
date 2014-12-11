require 'player'
require 'hand'
require 'deck'

describe Player do
  test_cards = [Card.new(:spades, :ace), Card.new(:hearts, :king), Card.new(:spades, :jack),
           Card.new(:diamonds, :four), Card.new(:clubs, :ten), Card.new(:spades, :five),
           Card.new(:diamonds, :five), Card.new(:clubs, :nine), Card.new(:spades, :six)]
  let (:deck) { Deck.new(@test_cards) }
  let(:player) { Player.new("Nick the Greek") }
  let(:pile) { double("DiscardPile") }
  let(:hand) { Hand.deal_from(deck) }
  
  it "should have the name Nick the Greek" do
    expect(player.name).to eq("Nick the Greek")
  end
  
  describe "#play_turn" do
    it "should draw a card if the hand is not playable"

    it "should raise an error if the deck is empty" 
    it "should try to discard when hand playable"
  end
  
end
