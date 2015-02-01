class BandsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_admin, only: [:create, :update, :destroy]

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      render :show
    else
      flash.now[:errors] = @band.errors.full_messages
    end
  end

  def show
    @band = Band.find(params[:id])
    # @albums = @band.albums
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      render :show
    else
      flash.now[:errors] = @band.errors.full_messages
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
