class RemoveUniquenessFromPlayers < ActiveRecord::Migration
  def change
  	remove_index :players, column: :rank
  end
end
