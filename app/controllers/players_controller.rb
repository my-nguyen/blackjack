class PlayersController < ApplicationController
  def new_game
    session[:name] = params[:name]
    session[:budget] = 500
    if (!params[:commit].nil? && params[:commit] == "Submit")
      redirect_to bet_path
    end
  end

  # this action is invoked either by a "Make Bet" button on the bet view
  # or by a "Yes" button on the play view
  def bet
    if (params[:commit] == "Make Bet")
      session[:wager] = params[:wager]
      session[:new_game] = true
      session[:player_turn] = true
      redirect_to play_path
    end
  end

  # this action never receives a commit button as part of its params because
  # it is invoked by a redirect_to from the: (a) bet; (b) hit; (c) stay; or
  # (d) next action
  def play
    # render text: params.inspect
    if (session[:new_game])
      Card.destroy_all

      @dealer_cards = Array.new
      @dealer_cards << new_card(false)
      @dealer_cards << new_card(false)

      @player_cards = Array.new
      @player_cards << new_card(true)
      @player_cards << new_card(true)
    else
      @dealer_cards = Card.where(player: false).to_a
      @player_cards = Card.where(player: true).to_a
    end
  end

  def game_over
  end

  def hit
    new_card(true)
    session[:new_game] = false
    redirect_to play_path
  end

  def stay
    session[:new_game] = false
    session[:player_turn] = false
    redirect_to play_path
  end

  def next
    new_card(false)
    redirect_to play_path
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
