class Api::V1::LeaderboardController < Api::V1::BaseApiController
  before_action :authenticate_user_from_token!

  def index
    @leaderboard = Leaderboard.all.order(user_score: :desc)

    render json: { leaderboard: trim_data(@leaderboard) }, status: :ok
  end

  private
    def trim_data(leaderboard)
      leaderboard.collect { |l| { id: l.id, user_score: l.user_score, user_name: l.user.name, user_id: l.user_id, created_at: l.created_at } }
    end
end
