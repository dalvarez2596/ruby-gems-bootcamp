class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User #{@user.email} was successfully updted'
    else
      render :edit
    end
  end
end
