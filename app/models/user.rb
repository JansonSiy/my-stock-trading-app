class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # if role left blank, it will not accept
         validates :role, presence: true
  
  def active_for_authentication?
    super && approved?
  end
  # super inherits ApplicationRecord && approved

  def inactive_message 
    approved? ? super : :not_approved
  end
  
end