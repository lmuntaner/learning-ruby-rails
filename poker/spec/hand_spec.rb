require 'spec_helper'
require 'hand.rb'

describe Hand do
  subject(:hand) { Hand.new }
  let(:card_one) { double('Card', :suit => :spade, :value => 14) }
  let(:card_two) { double('Card', :suit => :spade, :value => 13) }
  let(:card_three) { double('Card', :suit => :spade, :value => 12) }
  
  before(:each) do
    hand.draw([card_one, card_two, card_three])
  end
  
  describe "#draw" do
    context 'when not holding cards' do
      it "draws cards" do
        expect(hand.cards).to eq([card_one, card_two, card_three])
      end
    
      it "gets the proper numbers of cards" do
        expect(hand.cards.count).to eq(3)
      end
    end
    
    context 'when holding cards' do
      it "adds cards to the hand" do
        new_card = Card.new(:diamond, 5)
        hand.draw([new_card])
        expect(hand.cards).to eq([card_one, card_two, card_three, new_card])
      end
    end
  end
  
  describe "#discard" do
    before(:each) do
      hand.discard([hand[1], hand[2]])
    end
    it "reduces the cards in the hand" do
      expect(hand.cards.count).to eq(1)
    end
    it "removes the proper cards" do
      expect(hand.cards).to eq([card_one])
    end
  end
  
  describe "#in_hand?" do
    it "knows if you're holding the right card" do
      expect(hand.in_hand?(card_two)).to equal true
    end
  end
  
  describe "#count" do
    it "returns the number of cards in hand" do
      expect(hand.count).to eq(3)
    end
  end
end

describe HandValue do
  # let(:ace_of_spades) { double('Card', :suit => :spade, :value => 14) }
  # let(:king_of_spades) { double('Card', :suit => :spade, :value => 13) }
  #
  # let(:four_of_kind_hand) ...
  # let(:straight_hand)
  
  describe "#values_hash" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 14) }
    let(:card_two) { double('Card', :suit => :spade, :value => 13) }
    let(:card_three) { double('Card', :suit => :spade, :value => 12) }
    let(:card_four) { double('Card', :suit => :spade, :value => 11) }
    let(:card_five) { double('Card', :suit => :spade, :value => 10) }
    let(:card_six) { double('Card', :suit => :heart, :value => 14) } 
    
    it "returns a hash" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.values_hash).to be_an_instance_of(Hash)
    end
    it "returns paired values" do
      hand.draw([card_one, card_two, card_three, card_four, card_six])
      expect(hand.values_hash[14]).to eq(2)
    end
  end
  
  describe "straight flush?" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 14) }
    let(:card_two) { double('Card', :suit => :spade, :value => 13) }
    let(:card_three) { double('Card', :suit => :spade, :value => 12) }
    let(:card_four) { double('Card', :suit => :spade, :value => 11) }
    let(:card_five) { double('Card', :suit => :spade, :value => 10) }
    let(:card_six) { double('Card', :suit => :heart, :value => 14) }
    
    it "returns true if straight flush" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.straight_flush?).to be true
    end
    it "returns false if not straight flush" do
      hand.draw([card_one, card_two, card_three, card_four, card_six])
      expect(hand.straight_flush?).to be false
    end
  end
  
  describe "four of a kind?" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 14) }
    let(:card_two) { double('Card', :suit => :heart, :value => 14) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 14) }
    let(:card_four) { double('Card', :suit => :club, :value => 14) }
    let(:card_five) { double('Card', :suit => :spade, :value => 10) }
    let(:card_six) { double('Card', :suit => :heart, :value => 9) }
    
    it "returns true if four of a kind" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.four_kind?).to be true
    end
    it "returns false if not four of a kind" do
      hand.draw([card_one, card_two, card_three, card_five, card_six])
      expect(hand.four_kind?).to be false
    end
  end
  
  describe "pair?" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 14) }
    let(:card_two) { double('Card', :suit => :heart, :value => 14) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 2) }
    let(:card_four) { double('Card', :suit => :club, :value => 3) }
    let(:card_five) { double('Card', :suit => :spade, :value => 4) }
    let(:card_six) { double('Card', :suit => :heart, :value => 9) }
    
    it "returns true if pair" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.pair?).to be true
    end
    it "returns false if not pair" do
      hand.draw([card_one, card_four, card_three, card_five, card_six])
      expect(hand.pair?).to be false
    end
  end
  
  describe "three of a kind?" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 14) }
    let(:card_two) { double('Card', :suit => :heart, :value => 14) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 14) }
    let(:card_four) { double('Card', :suit => :club, :value => 3) }
    let(:card_five) { double('Card', :suit => :spade, :value => 4) }
    let(:card_six) { double('Card', :suit => :heart, :value => 9) }
    
    it "returns true if three" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.three_kind?).to be true
    end
    it "returns false if not three" do
      hand.draw([card_one, card_four, card_three, card_five, card_six])
      expect(hand.three_kind?).to be false
    end
  end
  
  describe "full house?" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 14) }
    let(:card_two) { double('Card', :suit => :heart, :value => 14) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 14) }
    let(:card_four) { double('Card', :suit => :club, :value => 3) }
    let(:card_five) { double('Card', :suit => :spade, :value => 3) }
    let(:card_six) { double('Card', :suit => :heart, :value => 9) }
    
    it "returns true if full house" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.full_house?).to be true
    end
    it "returns false if not full house" do
      hand.draw([card_one, card_four, card_three, card_five, card_six])
      expect(hand.full_house?).to be false
    end
  end
  
  describe "two pair?" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 14) }
    let(:card_two) { double('Card', :suit => :heart, :value => 14) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 10) }
    let(:card_four) { double('Card', :suit => :club, :value => 3) }
    let(:card_five) { double('Card', :suit => :spade, :value => 3) }
    let(:card_six) { double('Card', :suit => :heart, :value => 9) }
    
    it "returns true if two pair" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.two_pair?).to be true
    end
    it "returns false if not two pair" do
      hand.draw([card_one, card_four, card_three, card_five, card_six])
      expect(hand.two_pair?).to be false
    end
  end
  
  describe "kickers" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :heart, :value => 3) }
    
    it "returns the correct value" do
      hand.draw([card_one, card_two])
      expect(hand.kickers).to eq(3)
    end
    
    it "returns the same value with two of a kind" do
      hand.draw([card_one, card_two, card_two])
      expect(hand.kickers).to eq(3)
    end
  end
  
  describe "pair value" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :heart, :value => 2) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 3) }
    let(:card_four) { double('Card', :suit => :club, :value => 4) }
    let(:card_five) { double('Card', :suit => :spade, :value => 5) }
    
    it "returns correct value" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.pair_value).to eq((2 ** 21) + (2 * (2 ** 17)) + hand.kickers)
    end
  end
  
  describe "two pair value" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :heart, :value => 2) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 3) }
    let(:card_four) { double('Card', :suit => :club, :value => 3) }
    let(:card_five) { double('Card', :suit => :spade, :value => 5) }
    
    it "returns correct value" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.two_pair_value).to eq(
      (2 * (2 ** 21)) + (3 * (2 ** 17)) + (2 * (2 ** 13)) + hand.kickers)
    end
  end
  
  describe "three of a kind value" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :heart, :value => 2) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 2) }
    let(:card_four) { double('Card', :suit => :club, :value => 3) }
    let(:card_five) { double('Card', :suit => :spade, :value => 5) }
    
    it "returns correct value" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.three_kind_value).to eq(
      (3 * (2 ** 21)) + (2 * (2 ** 17)) + hand.kickers)
    end
  end
  
  describe "straight value" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :heart, :value => 3) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 4) }
    let(:card_four) { double('Card', :suit => :club, :value => 5) }
    let(:card_five) { double('Card', :suit => :spade, :value => 6) }
    
    it "returns correct value" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.straight_value).to eq(
      (4 * (2 ** 21)) + (6 * (2 ** 17)) + hand.kickers)
    end
  end
  
  describe "flush value" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :spade, :value => 3) }
    let(:card_three) { double('Card', :suit => :spade, :value => 4) }
    let(:card_four) { double('Card', :suit => :spade, :value => 5) }
    let(:card_five) { double('Card', :suit => :spade, :value => 7) }
    
    it "returns correct value" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.flush_value).to eq(
      (5 * (2 ** 21)) + (7 * (2 ** 17)) + hand.kickers)
    end
  end
  
  describe "full house value" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :heart, :value => 2) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 2) }
    let(:card_four) { double('Card', :suit => :club, :value => 3) }
    let(:card_five) { double('Card', :suit => :spade, :value => 3) }
    
    it "returns correct value" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.full_house_value).to eq(
      (6 * (2 ** 21)) + (2 * (2 ** 17)) + hand.kickers)
    end
  end
  
  describe "for of a kind value" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :heart, :value => 2) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 2) }
    let(:card_four) { double('Card', :suit => :club, :value => 2) }
    let(:card_five) { double('Card', :suit => :spade, :value => 3) }
    
    it "returns correct value" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.four_kind_value).to eq(
      (7 * (2 ** 21)) + (2 * (2 ** 17)) + hand.kickers)
    end
  end
  
  describe "straight flush value" do
    subject(:hand) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :spade, :value => 3) }
    let(:card_three) { double('Card', :suit => :spade, :value => 4) }
    let(:card_four) { double('Card', :suit => :spade, :value => 5) }
    let(:card_five) { double('Card', :suit => :spade, :value => 6) }
    
    it "returns correct value" do
      hand.draw([card_one, card_two, card_three, card_four, card_five])
      expect(hand.straight_flush_value).to eq(
      (8 * (2 ** 21)) + (6 * (2 ** 17)) + hand.kickers)
    end
  end
  
  describe "value method" do
    subject(:hand1) { Hand.new }
    let(:card_one) { double('Card', :suit => :spade, :value => 2) }
    let(:card_two) { double('Card', :suit => :spade, :value => 3) }
    let(:card_three) { double('Card', :suit => :diamond, :value => 2) }
    let(:card_four) { double('Card', :suit => :diamond, :value => 3) }
    let(:card_five) { double('Card', :suit => :spade, :value => 6) }
    
    subject(:hand2) { Hand.new }
    let(:card_six) { double('Card', :suit => :spade, :value => 2) }
    let(:card_seven) { double('Card', :suit => :club, :value => 2) }
    let(:card_eight) { double('Card', :suit => :heart, :value => 2) }
    let(:card_nine) { double('Card', :suit => :spade, :value => 5) }
    let(:card_ten) { double('Card', :suit => :spade, :value => 6) }
    
    it "compares values correctly" do
      hand1.draw([card_one, card_two, card_three, card_four, card_five])
      hand2.draw([card_six, card_seven, card_eight, card_nine, card_ten])
      expect(hand1.get_value < hand2.get_value).to be true
    end
  end
  
end