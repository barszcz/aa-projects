class CatRentalRequestsController < ApplicationController
  before_action :require_cat_belongs_to_user, only: [:approve, :deny]

  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(rental_params)
    @cat_rental_request.user_id = current_user.id

    if @cat_rental_request.save
      redirect_to cats_url
    else
      render json: @cat_rental_request.errors.full_messages, status: :unprocessable_entity
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat)
  end

  private
  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
