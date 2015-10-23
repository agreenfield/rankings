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


  def self.getnames
    print "running names"
    @m = Match.select("matches.date, w.name, l.name").join('INNER JOIN players AS w ON matches.winner_id = w.id INNER JOIN players as l ON matches.loser_id = l.id')
    print @m
  end

  def wun
    puts "hello"
  end

end
