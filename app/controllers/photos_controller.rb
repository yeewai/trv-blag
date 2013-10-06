class PhotosController < ApplicationController
  def index
  end

  def create
    @photo = Photo.create(params[:photo])
  end

  def destroy
  end
end
