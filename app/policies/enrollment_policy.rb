class EnrollmentPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
  end

  def index?
    @user.has_role?(:admin)
  end

  def edit?
    @record.user_id == @user.id
  end

  def update?
    @record.user_id == @user.id
  end

  def destroy?
    @user.has_role?(:admin)
  end
end
