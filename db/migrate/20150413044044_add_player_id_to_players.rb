class AddPlayerIdToPlayers < ActiveRecord::Migration
  def change
    add_reference :players, :player, index: true, foreign_key: true
  end
end
