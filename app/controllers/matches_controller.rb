class MatchesController < ApplicationController

  def recent
    @matches = Match.order(date: :desc)
  end

  def index
    @matches = Match.active_players_by_rank
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to matches_recent_path, notice: 'Match was recorded'
      @match.adjust_players
    else
      @match.errors.messages do |message| 
        flash[:notice] << message
      end
        render :new
    end
  end


  private

  def match_params
    params.require(:match).permit(:date, :winner_id, :loser_id, 
                                  :winner_score, :loser_score)
  end

end 