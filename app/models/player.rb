class Player < ActiveRecord::Base

  def matches
    Match.where("winner_id = ? OR loser_id = ?", id, id)
  end

  def self.active_players
    Player.where("hidden = ? AND deleted = ?", false, false)
  end

  def self.active_players_by_rank
    active_players.order(rank: :asc)
  end

  def self.active_players_by_name
    active_players.order(name: :asc)
  end

  def self.inactive_players_by_name
    Player.where("hidden = ? and deleted = ?", true, false).order(name: :asc)
  end

  def hidden?
    hidden == true
  end

  def deleted?
    deleted == true
  end

  def active?
    !hidden? and !deleted?
  end

  def inactive?
    hidden? or deleted?
  end

  def self.name_selection
    player_list = Array.new
    Player.select(:name) { |p| player_list << [ p.name, p.id ] }
    player_list
  end

  def self.move_players_down(starting_rank)
    Player.where("rank >= ?", starting_rank).update_all("rank = rank + 1")
  end

  def self.move_players_up(starting_rank)
    Player.where("rank >= ?", starting_rank).update_all("rank = rank - 1")
  end

	def insert
    #How many ranked players already?
		number_of_players = Player.active_players.count

    if inactive?
      # No need to adjust rankings
      self.rank = 999
    elsif rank == 0 or rank.nil? or rank > number_of_players 
      # If the requested rank is out of bounds, set to lowest rank
      self.rank = number_of_players + 1
    else
      # Otherwise, move players down to make room for insertion
      Player.move_players_down(rank)
    end

    # Now insert player at desired rank
    save
  end

  def hide
    # If they are currently ranked, move them up
    if active?
      Player.move_players_up(rank + 1)
    end
    self.hidden = true
    self.rank = 999
  end

  def delete
    if active?
      Player.move_players(rank+1)
    end
    self.deleted = true
    self.rank = 999
  end

end
