class PlayersController < ApplicationController
	def index
		@players = Player.order(rank: :asc)
	end

  def by_name
    @players = Player.order(name: :asc)
  end

	def new
		@player = Player.new
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
    params.require(:player).permit(:name, :email, :phone, :rank, :joined)
  end
