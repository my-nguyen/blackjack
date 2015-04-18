class PlayersController < ApplicationController
  def bet
  end

  def play
    # render text: params.inspect
    if params[:commit] != "Yes" && params[:commit] != "No"
      if params[:commit] == "Make Bet"
        Card.destroy_all

        @dealer_cards = Array.new
        @dealer_cards << new_card(false)
        @dealer_cards << new_card(false)

        @player_cards = Array.new
        @player_cards << new_card(true)
        @player_cards << new_card(true)
      elsif params[:commit] == "Next" || params[:commit] == "Hit" || params[:commit] == "Stay"
        @dealer_cards = Card.where(player: false).to_a
        @player_cards = Card.where(player: true).to_a

        if params[:commit] == "Hit"
          @player_cards << new_card(true)
        elsif params[:commit] == "Next"
          @dealer_cards << new_card(false)
        end
      end
      # render "/play"
    elsif params[:commit] == "Yes"
      redirect_to bet_path
    elsif params[:commit] == "No"
      redirect_to game_over_path
    end
  end

  def game_over
  end

  private
  def new_card is_player
    suits = %w(clubs diamonds hearts spades)
    numbers = %w(king ace 2 3 4 5 6 7 8 9 10 jack queen)

    begin
      suit = suits[rand(4)]
      number = numbers[rand(13)]
    end while Card.where(suit: suit, number: number).any?
    Card.create(player: is_player, suit: suit, number: number)
  end
end
