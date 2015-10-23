class Player < ActiveRecord::Base

  def matches
    Match.where("winner_id = ? OR loser_id = ?", id, id)
  end

  def self.name_selection
    player_list = Array.new
    Player.select(:name) { |p| player_list << [ p.name, p.id ] }
    player_list
  end

  def self.move_players_down(starting_rank)
  Player.where("rank >= ?", starting_rank).update_all("rank = rank + 1")
  # @players = Player.where("rank >= ?", starting_rank
  end

	def insert
    #How many in the table already?
		 number_of_players = Player.count

    # If the requested rank is out of bounds, append at the bottom of list
    if rank == 0 or rank.nil? or rank > number_of_players
      # This took me ages to figure out
      # On the left side of an assignment you have to use self - no error arises
      # it must create a local variable
      self.rank = number_of_players + 1
      print "desired rank is now #{rank}"
    else
      # Otherwise, move players down to make room for insertion
      Player.move_players_down(rank)
    end

    # Now insert player at desired rank
    save
  end

  def delete
  end

  def swap
  end
end
