class User < ActiveRecord::Base
  before_create :generate_authentication_token

  has_many :games

  VALID_EMAIL_REGEX = /[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9\-.]/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, if: :email
  validates :password, length: { minimum: 6, maximum: 20 }, if: :password

  def generate_authentication_token
    loop do
      self.access_token = SecureRandom.urlsafe_base64(nil, false)
      break unless User.find_by(access_token: access_token)
    end
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
