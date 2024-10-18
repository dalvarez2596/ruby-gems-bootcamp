class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  def to_s
    email
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "email", "sign_in_count" ]
  end

  has_many :courses
end
