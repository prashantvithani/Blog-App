class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  def dob=(date)
    date = Date.strptime(date, "%m/%d/%Y") if date.is_a?(String)
    write_attribute(:dob, date)
  end
end
