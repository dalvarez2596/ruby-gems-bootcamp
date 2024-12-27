class CoursePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    @record.published && @record.approved || @user.present? && @user.has_role?(:admin) || @user.present? && @record.user_id == @user.id || @user.present? && @record.bought(@user)
  end

  # another logic for show
  # def show?
  #   # Check if the record is published and approved
  #   return true if @record.published && @record.approved
    
  #   # Check user conditions if the user is present
  #   return true if @user.present? && (
  #     @user.has_role?(:admin) ||
  #     @record.user_id == @user.id ||
  #     @record.bought(@user)
  #   )
    
  #   # If none of the conditions are met, return false
  #   false
  # end

  def edit?
    @record.user == @user
  end

  def update?
    @record.user == @user
  end

  def new?
    @user.has_role?(:teacher)
  end

  def create?
    @user.has_role?(:teacher)
  end

  def destroy?
    @record.user == @user && @record.enrollments.none?
    # @user.has_role?(:admin) or @record.user == @user
  end

  def approve?
    @user.has_role?(:admin)
  end

  def owner?
    @record.user == @user
  end

  def admin_or_owner?
    @user.has_role?(:admin) or @record.user == @user
  end
end
