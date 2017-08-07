class Api::V1::GamesController < Api::V1::BaseApiController
  before_action :authenticate_user_from_token!
  before_action :find_game, only: [:show]

  # GET /games
  # GET /games.json
  def index
    @games = Game.where('user_id = ?', @current_user.id).order(created_at: :desc)
    if @games.present?
      render json: { games: trim_data(@games) }, status: :ok
    else
      render json: { :status => "204", :message => "User doesn't have games" }, status: :no_content
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    render json: @game
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.user = @current_user
    if @game.save
      render json: { status: 'Game created successfully', game: @game }, status: :created
    else
     render json: { errors: @game.errors.full_messages }, status: :bad_request
    end
  end

  private
    def find_game
      @game = Game.find(params[:id])
      render nothing: true, status: :not_found unless @game.present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:user_score, :user_id, :opponent_score, :opponent_id)
    end

    def trim_data(games)
      games.collect { |g| { id: g.id, user_score: g.user_score, user_id: g.user_id, opponent_score: g.opponent_score, opponent: g.opponent.name, created_at: g.created_at } }
    end
end
