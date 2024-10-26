class User < ApplicationRecord
  rolify

  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  def to_s
    email
  end

  def username
    self.email.split(/@/).first
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "email", "sign_in_count" ]
  end

  has_many :courses

  # this is more basic
  # def assign_default_role
  #   self.add_role(:student) if self.roles.blank?
  # end

  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher)
      self.add_role(:stuent)
    else
      self.add_role(:student) if self.roles.blank?
      self.add_role(:teacher)  # to allow any user to create own courses
    end
  end

  private

  validate :must_have_a_role, on: :update
  def must_have_a_role
    errors.add(:role_ids, "Must have a at least one role.") unless roles.any?
  end
end
