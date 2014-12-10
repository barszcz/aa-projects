class GoalsController < ApplicationController
  before_action :ensure_logged_in
  before_action :private_bouncer, except: [:new, :create]

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

  def update
    if @goal.update(goal_params)
      render :show
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def complete
    @goal.toggle!(:completed)
    render :show
  end

  def destroy

    @goal.destroy
    redirect_to user_url(@goal.user)
  end

  private

  def goal_params
    params.require(:goal).permit(:aim, :public)
  end

  def private_bouncer
    @goal = Goal.find(params[:id])
    redirect_to user_url(@goal.user) unless @goal.user == current_user
  end
end
