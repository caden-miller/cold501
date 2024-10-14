# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :set_photo, except: %i[index new create]
  before_action :authenticate_user!

  # GET /photos
  def index
    @photos = Photo.order(:id)
  end

  # GET /photos/1
  def show; end

  # GET /photos/new
  def new
    puts "Inside New Photo"
    @photo = Photo.new
    puts "Leaving New Photo"
  end
  

  # GET /photos/1/edit
  def edit 
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  # POST /photos
  def create
    puts "Inside Create Photo"
    @photo = current_user.photos.build(photo_params)
    # @photo = Photo.new(photo_params)
    # @photo.user = current_user
  
    if @photo.save
      puts "Photo Created"
      respond_to do |format|
        
        format.html { redirect_to photos_path, notice: "Photo Created" }
        format.turbo_stream
      end
    else
      puts "Photo Not Created"
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to photos_path, notice: 'Photo was successfully updated.' }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            dom_id(@photo),
            partial: 'photos/form',
            locals: { photo: @photo }
          ), status: :unprocessable_entity
        }
      end
    end
  end

  def delete; end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'Photo was successfully deleted.' }
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def photo_params
    params.require(:photo).permit(:title, :description, :image)
  end
end
