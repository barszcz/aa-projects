class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    @goal.completed = false
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def complete
    @goal = Goal.find(params[:id])
    @goal.toggle!(:completed)
    render :show
  end

  private

  def goal_params
    params.require(:goal).permit(:aim, :public)
  end
end
