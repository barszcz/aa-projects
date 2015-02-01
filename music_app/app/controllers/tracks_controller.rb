class TracksController < ApplicationController
  before_action :ensure_logged_in

  def new
    @album = Album.find(params[:album_id])
    @track = Track.new(album_id: params[:album_id])
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      render :show
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to album_url(@track.album)
  end

  private

  def track_params
    params.require(:track).permit([:title, :kind, :album_id, :lyrics])
  end
end
