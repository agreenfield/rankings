class Match < ActiveRecord::Base


  include ActiveModel::Validations  #needed to define a custom validator



	belongs_to :winner, :class_name => 'Player', :foreign_key => 'winner_id'
  belongs_to :loser, :class_name => 'Player', :foreign_key => 'loser_id'

  validates_associated :winner, :loser
  validates :winner_score, numericality: {greater_than_or_equal_to: 0, 
                                          less_than_or_equal_to: 9}  
  validates :loser_score, numericality: {greater_than_or_equal_to: 0, 
                                          less_than_or_equal_to: 9}

  validates :date, :winner_id, :loser_id, presence: true                                        

  
  # Swaps the ranks of a match's players if the lower ranked player won
  # Uses the associations defined for match to access winner and loser
  def adjust_players
    print "winner rank is #{winner.rank}, loser_rank is #{loser.rank}"
    if winner.rank > loser.rank
      temp = winner.rank
      winner.update(rank: loser.rank)
      loser.update(rank: temp)
    end
  end

  class MyValidator < ActiveModel::Validator
    def validate(match)
      if match.winner_id == match.loser_id
        match.errors[:players] << "No playing with yourself please!"
      end
      if match.winner_score < match.loser_score
        match.errors[:loser] << "Winner score must be higher"
      end
    end
  end

  validates_with MyValidator




end
