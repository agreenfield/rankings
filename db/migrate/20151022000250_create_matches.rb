class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :date
      t.integer :winner_id
      t.integer :loser_id
      t.integer :winner_score
      t.integer :loser_score

      t.timestamps null: false
    end
    
    add_foreign_key :players, :matches, column: :winner_id, primary_key: :id
    add_foreign_key :players, :matches, column: :loser_id, primary_key: :id
  end
end
