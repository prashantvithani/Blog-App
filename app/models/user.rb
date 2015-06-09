class User < ActiveRecord::Base
  include Tenacity
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

	validates :full_name, :email, presence: true
	validates :email,  :uniqueness => true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  t_has_many :archived_posts, dependent: :destroy
  t_has_many :archived_comments, dependent: :destroy
  
  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.token = auth.credentials.token
        user.email = auth.info.email
        user.full_name = auth.info.name
        user.password = Devise.friendly_token[0,20]
      end
  end

  def self.all_except(user)
    where.not(id: user)
  end
end
