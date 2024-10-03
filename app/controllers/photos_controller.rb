# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show edit update destroy delete]
  before_action :authenticate_user!

  # GET /photos
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  def show; end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit; end

  # POST /photos
  def create
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      redirect_to @photo, notice: 'Photo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: 'Photo was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete; end

  def destroy
    # @photo.destroy

    # respond_to do |format|
    #   format.html { redirect_to "localhost:3000/photos", notice: 'Photo was successfully destroyed.' }
    #   format.json { head :no_content }

    if @photo.destroy
      flash[:success] = 'Photo was successfully deleted.'
      redirect_to photos_path # Redirect to index or some other page after deletion
    else
      flash[:error] = 'Photo could not be deleted.'
      redirect_to @photo # Redirect back to the photo's show page if it couldn't be deleted
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
