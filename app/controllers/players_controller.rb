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
      if (params[:wager] == "" || params[:wager].to_i > session[:budget])
        render :bet
      else
        session[:wager] = params[:wager]
        session[:new_game] = true
        session[:player_turn] = true
        redirect_to play_path
      end
    else
      if session[:budget] == 0
        redirect_to game_over_path
      end
    end
  end

  # this action never receives a commit button as part of its params because
  # it is invoked by a redirect_to from the: (a) bet; (b) hit; (c) stay; or
  # (d) next action
  def play
    # render text: params.inspect
    @dealer_cards = Cards.new(false)
    @player_cards = Cards.new(true)

    if (session[:new_game])
      Cards.destroy_all

      @dealer_cards.deal
      @dealer_cards.deal

      @player_cards.deal
      @player_cards.deal
    else
      @dealer_cards.load
      @player_cards.load
    end
  end

  def game_over
  end

  def hit
    @player_cards = Cards.new(true)
    @player_cards.deal
    session[:new_game] = false
    redirect_to play_path
  end

  def stay
    session[:new_game] = false
    session[:player_turn] = false
    redirect_to play_path
  end

  def next
    @dealer_cards = Cards.new(false)
    @dealer_cards.deal
    redirect_to play_path
  end
end
