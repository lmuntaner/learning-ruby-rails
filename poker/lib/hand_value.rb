# Remember to explain the calculatino to get the hand value
# About the 4 different values in binary

module HandValue
  def get_value
    straight_flush_value || four_kind_value || full_house_value || 
    flush_value || straight_value || three_kind_value ||
    two_pair_value || pair_value || high_card_value
  end
  
  def values_hash
    cards_hash = Hash.new { |k, v| v = 0 }
    @cards.each do |card|
      cards_hash[card.value] += 1
    end
    cards_hash
  end
  
  def straight_flush?
    flush? && straight?
  end
  
  def straight_flush_value
    if straight_flush?
      id_value = 8 * (2 ** 21)
      maker = values_hash.keys.max
      hand_maker = maker * (2 ** 17)
      id_value + hand_maker + kickers
    else
      false
    end
  end
  
  def four_kind?
    values_hash.values.any? { |key| key == 4 }
  end
    
  def four_kind_value
    if four_kind?
      id_value = 7 * (2 ** 21)
      hand_maker = get_maker_value(4)
      id_value + hand_maker + kickers
    else
      false
    end
  end

  def full_house?
    pair? && three_kind?
  end
  
  def full_house_value
    if full_house?
      id_value = 6 * (2 ** 21)
      hand_maker = get_maker_value(3)
      id_value + hand_maker + kickers
    else 
      false
    end
  end
  
  def flush?
    first_suit = @cards.first.suit
    @cards.all? { |card| card.suit == first_suit}
  end
  
  def flush_value
    if flush?
      id_value = 5 * (2 ** 21)
      maker = values_hash.keys.max
      hand_maker = maker * (2 ** 17)
      id_value + hand_maker + kickers
    else
      false
    end
  end
  
  def straight?
    values = @cards.map { |card| card.value }
    values_sorted = values.sort
    values_sorted.each_with_index do |value, index|
      next if index == values.count - 1
      if values_sorted[index + 1] - value != 1
        return false
      end
    end
    true
  end
  
  def straight_value
    if straight?
      id_value = 4 * (2 ** 21)
      maker = values_hash.keys.max
      hand_maker = maker * (2 ** 17)
      id_value + hand_maker + kickers
    else
      false
    end
  end
  
  def three_kind?
    values_hash.values.any? { |key| key == 3 }
  end
  
  def three_kind_value
    if three_kind?
      id_value = 3 * (2 ** 21)
      hand_maker = get_maker_value(3)
      id_value + hand_maker + kickers
    else
      false
    end
  end
  
  def two_pair?
    values_hash.values.sort == [1, 2, 2]
  end
  
  def two_pair_value
    if two_pair?
      id_value = 2 * (2 ** 21)
      makers = values_hash.select { |k, v| v == 2 }.keys
      hand_maker = makers.max * (2 ** 17)
      hand_maker2 = makers.min * (2 ** 13)
      id_value + hand_maker + hand_maker2 + kickers
    else
      false
    end
  end
  
  def pair?
    values_hash.values.any? { |key| key == 2 }
  end
  
  def pair_value
    if pair?
      id_value = 2 ** 21
      hand_maker = get_maker_value(2)
      id_value + hand_maker + kickers
    else
      false
    end
  end
  
  def get_maker_value(n)
    maker = values_hash.select { |k, v| v == n}.keys.first
    maker * (2 ** 17)
  end
  
  def kickers
    values_hash.keys.inject(0) { |sum, key| sum + (2 ** (key - 2)) }
  end
  
  def high_card_value
    kickers
  end
  
end