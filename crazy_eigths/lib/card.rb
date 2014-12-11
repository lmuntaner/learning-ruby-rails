# -*- coding: utf-8 -*-
require 'colorize'

class Card
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦".colorize(:red),
    :hearts   => "♥".colorize(:red),
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  def self.suits
    SUIT_STRINGS.keys
  end

  def self.values
    VALUE_STRINGS.keys
  end

  attr_reader :suit, :value

  def initialize(suit, value)
    unless Card.suits.include?(suit) and Card.values.include?(value)
      raise "illegal suit (#{suit}) or value (#{value})"
    end

    @suit, @value = suit, value
  end

  def to_s
    VALUE_STRINGS[value].colorize((suit == :diamonds || suit == :hearts) ?
                                  :red : :default) + SUIT_STRINGS[suit]
  end
end
