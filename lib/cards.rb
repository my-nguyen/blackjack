class MyCard
  attr_reader :value, :suit

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s()
    suits = %w(clubs diamonds hearts spades)
    values = %w(king ace 2 3 4 5 6 7 8 9 10 jack queen)
    "#{suits[@suit]}_#{values[@value]}.jpg"
  end
end

class Cards
  attr_reader :cards

  @@all_cards = []

  def self.clear
    @@all_cards.clear
  end

  def initialize(is_player)
    @cards = Array.new
    @is_player = is_player
  end

  def deal()
    # avoid getting a card that's exactly the same as one already been generated
    begin
      suit = rand(4)
      value = rand(13)
    end while include?(suit, value)
    card = new_card(suit, value, @is_player)
    @cards << card
    save card
  end

  def load
    @cards = Array.new
    Card.where(is_player: @is_player).to_a.each do |card|
      @cards << MyCard.new(card.suit.to_i, card.value.to_i)
    end
  end

  def self.destroy_all
    Card.destroy_all
  end

  def value
    values = [10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10]
    ace_dealt = false
    sum = 0
    @cards.each do |card|
      value = values[card.value]
      if (value == 1)
        ace_dealt = true
      end
      sum += value
    end

    # recalculate sum if an Ace was dealt
    if ace_dealt && sum <= 11
      sum += 10
    end

    return sum
  end

  private
  def include?(suit, value)
    Card.where(suit: suit, value: value).any?
  end

  def new_card(suit, value, is_player)
    # save in database
    Card.create(is_player: is_player, suit: suit, value: value)
    # save in memory
    MyCard.new(suit, value)
  end

  def save(card)
    card
  end
end
