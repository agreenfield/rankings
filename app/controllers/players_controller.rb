class PlayersController < ApplicationController
	def index
		@players = Player.where(hidden: false, deleted: false).order(rank: :asc)
	end

  def by_name
    @active_players = Player.active_players_by_name
    @inactive_players = Player.inactive_players_by_name
  end

	def new
		@player = Player.new
	end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    @now_hidden = !@player.hidden and params[:hidden]
    @now_unhidden = @player.hidden and !params[:hidden]
    @success = @player.update_attributes(player_params)
    if @success 
      if @now_hidden
        @player.hide
      elsif
        @now_unhidden
        @player.unhide
      end
      redirect_to players_path, notice: 'Player was updated successfully'
    else
      render :edit
    end
  end

  def matches_played
    @player = Player.find(params[:id])
    @matches = @player.matches
  end

	def create
		@player = Player.new(player_params)
    if @player.insert
      redirect_to players_path, notice: 'Player was added'
    else
      render :new
    end
  end
end


private
  # Never trust parameters from the scary internet, only allow white list
  def player_params
    params.require(:player).permit(:name, :email, :phone, :rank, :joined, :hidden, :deleted)
  end
