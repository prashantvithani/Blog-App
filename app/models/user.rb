class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def dob=(date)
    date = date.to_date if date.is_a?(String)
    write_attribute(:dob, date)
  end
end
