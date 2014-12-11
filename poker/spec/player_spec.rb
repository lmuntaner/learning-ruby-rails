require 'spec_helper'
require 'player.rb'

describe Player do
  subject(:player) { Player.new(100) }
  context 'at the beginning' do
    it "has an empty hand" do
      expect(player.hand.cards.count).to eq(0)
    end
    it "has a stack" do
      expect(player.stack).to eq(100)
    end
  end
  
  context 'playing the game' do
    it 'calls bets' do
      allow(player).to receive(:gets) { "c\n" }
      expect(player.turn(50)).to eq([:call, 50])
    end
    it 'raises bets' do
      allow(player).to receive(:gets) { "r 100\n" }
      expect(player.turn(50)).to eq([:raise, 100])
    end
    it 'folds and stops playing that hand' do
      allow(player).to receive(:gets) { "f\n" }
      expect(player.turn(50)).to eq([:fold, 0])
    end
    it 'gets money when winning the game' do
      player.win_pot(100)
    end
  end
end