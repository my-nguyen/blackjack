module PlayersHelper
  def value cards
    ace_dealt = false
    sum = 0
    cards.each do |card|
      if (card.number == 'ace')
        ace_dealt = true
        sum += 1
      elsif (card.number == 'jack' || card.number == 'queen' || card.number == 'king')
        sum += 10
      else
        sum += card.number.to_i
      end
    end

    # recalculate sum if an Ace was dealt
    if ace_dealt && sum <= 11
      sum += 10
    end

    return sum
  end

  def to_image(card)
    "#{card.suit}_#{card.number}.jpg"
  end
end
