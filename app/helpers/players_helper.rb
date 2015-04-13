module PlayersHelper
  def value(cards)
    ace_dealt = false
    sum = 0
    cards.each do |card|
      if (card.value == 'ace')
        ace_dealt = true
        sum += 1
      elsif (card.value == 'jack' || card.value == 'queen' || card.value == 'king')
        sum += 10
      else
        sum += card.value.to_i
      end
    end

    # recalculate sum if an Ace was dealt
    if ace_dealt && sum <= 11
      sum += 10
    end

    return sum
  end

  def to_image(card)
    "#{card.suit}_#{card.value}.jpg"
  end

  def report(player, change, status)
    if change
      player.update_attribute(:budget, player.budget + change)
    end
    status + " #{player.name} now has #{player.budget}."
  end
end
