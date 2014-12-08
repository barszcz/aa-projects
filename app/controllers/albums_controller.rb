class AlbumsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @band = Band.find(params[:band_id])
    @album = Album.new(band_id: params[:band_id])
  end

  def create
    @album = Album.new(album_params)
    @band = Band.find(params[:album][:band_id])
    if @album.save
      render :show
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      render :show
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band)
  end

  private

  def album_params
    params.require(:album).permit([:title, :kind, :band_id])
  end
end
