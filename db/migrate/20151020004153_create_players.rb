class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :rank
      t.datetime :joined

      t.timestamps null: false
    end
    add_index :players, :rank, unique: true
  end
end
