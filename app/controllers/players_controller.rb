class PlayersController < ApplicationController
  def index
    @playboy = Player.new
  end

  def new
    # render text: params.inspect
    @playboy = Player.find(params[:id])
  end

  def create
    @playboy = Player.new(player_params)
    # @playboy = Player.new(name: params[:player][:name])
    if @playboy.save
      @dealer = Player.create(name: "dealer", player_id: @playboy.id)
      new_card @dealer
      new_card @dealer

      @playboy.update_attributes(budget: 500, player_id: @dealer.id)
      new_card @playboy
      new_card @playboy

      redirect_to player_path(@playboy)
    end
  end

  def show
    @playboy = Player.find(params[:id])
  end

  def update
    if (params[:commit] == "Yes")
      redirect_to new_player_path(@playboy)
    elsif (params[:commit] == "No")
      redirect_to game_over_path
    else
      @dealer = Player.find_by(name: "dealer", player_id: params[:id])

      @playboy = Player.find(params[:id])
      logger.debug "TRUONG:: id: #{params[:id]}, name: #{@playboy.id}"
      if (params[:commit] == "Make Bet")
        @playboy.update_attribute(:wager, params[:player][:wager])
      elsif (params[:commit] == "Hit")
        new_card @playboy
      end
    end
  end

  def game_over
  end

  private
  def player_params
    params.require(:player).permit(:name, :budget, :wager)
  end

  def new_card(player)
    suits = %w(clubs diamonds hearts spades)
    values = %w(king ace 2 3 4 5 6 7 8 9 10 jack queen)

    player.cards.find_or_create_by(suit: suits[rand(4)], value: values[rand(13)])
  end
end
