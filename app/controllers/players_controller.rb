class PlayersController < ApplicationController
  def index
    @playboy = Player.new
  end

  def new
    # render text: params.inspect
    # hardcode the player id for now, but afterwards must find some other way to look up player
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
    @playboy = Player.find(params[:id])
    if (params[:commit] == "Make Bet")
      @playboy.update_attribute(:wager, params[:player][:wager])
    elsif (params[:commit] == "Hit")
      new_card @playboy
    end

    @dealer = Player.find_by(name: "dealer", player_id: params[:id])
    logger.debug "TRUONG:: dealer: #{@dealer.nil? ? '' : 'not '} nil, player_id: #{params[:id]}}"
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
