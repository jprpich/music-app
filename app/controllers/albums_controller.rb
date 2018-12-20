class AlbumsController < ApplicationController

  def new
    @bands = Band.all 
    render :new
  end

  def create 
    album = Album.new(album_params)
    if album.save 
      redirect_to band_url(album.band)
    else
      flash.now[:errors] = album.errors.full_messages
      render :new 
    end
  end
  
  def album_params
    params.require(:album).permit(:title, :band_id, :live)
  end
end
