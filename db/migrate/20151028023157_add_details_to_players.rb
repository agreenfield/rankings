class AddDetailsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :hidden, :boolean, default: false
    add_column :players, :deleted, :boolean, default: false
  end
end
