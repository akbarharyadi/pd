class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  def confirmation_required?
    !confirmed?
  end
  
  def self.current=(user)
    Thread.current[:current_user] = user
  end

  def self.current
    Thread.current[:current_user]
  end
end
