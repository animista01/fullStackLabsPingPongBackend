class Game < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key:  "user_id"
  belongs_to :opponent, class_name: "User", foreign_key: "opponent_id"

  validates :user, presence: true
  validates :user_score, presence: true
  validates :opponent_score, presence: true
  validates :opponent, presence: true

  validate :conditions_before_save
  after_create :save_leaderboard

  def save_leaderboard
    user = Leaderboard.find_by(user_id: self.user.id)
    if user.present?
      user.update_attribute(:user_score, user.user_score + self.user_score)
    else
      new_leaderboard = Leaderboard.new({ user_score: self.user_score, user_name: self.user.name, user_id: self.user.id })
      new_leaderboard.save
    end
  end

  def conditions_before_save
    if !user_score || !opponent_score
      errors.add(:base, "Both scores are required")
    elsif user_score < 21 && opponent_score < 21
      errors.add(:base, "Final score must be 21 for a player")
    elsif user_score > 21 || opponent_score > 21
      errors.add(:base, "Final points must be less than 21 for players")
    elsif (user_score - opponent_score < 2 && opponent_score - user_score < 2)
      errors.add(:base, "Final points between players must be 2 points of difference")
    end
  end
end
