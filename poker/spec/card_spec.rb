require "spec_helper"
require 'card.rb'

describe Card do
  subject(:card) { Card.new(:spade, 14) }
  
  
  it "knows its value" do
    expect(card.value).to eq(14)
  end
  
  it "knows its suit" do
    expect(card.suit).to eq(:spade)
  end
  
  it "prints a symbol with color" do
    expect(card.to_s).to eq("A".colorize(:black))
  end
end