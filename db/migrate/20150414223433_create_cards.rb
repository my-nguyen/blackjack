class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.boolean :player
      t.string :suit
      t.string :number

      t.timestamps null: false
    end
  end
end
