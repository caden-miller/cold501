# frozen_string_literal: true

# PhotosController manages photo uploads, updates, deletions, and galleries.
# It ensures that photos are associated with users and handles validations during photo creation and updates.
class PhotosController < ApplicationController
  before_action :set_photo, except: %i[index new create gallery]

  # GET /photos
  def index
    @photos = Photo.order(:id)
  end

  # GET /photos/1
  def show; end

  # GET /photos/new
  def new
    @photo = Photo.new
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
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      handle_create_success
    else
      handle_create_failure
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      handle_update_success
    else
      handle_update_failure
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

  def gallery
    @photos = Photo.all
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :image)
  end

  def handle_create_success
    Rails.logger.debug 'Photo Created'
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'Photo Created' }
      format.turbo_stream
    end
  end

  def handle_create_failure
    Rails.logger.debug 'Photo Not Created'
    render :new, status: :unprocessable_entity
  end

  def handle_update_success
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to photos_path, notice: 'Photo was successfully updated.' }
    end
  end

  def handle_update_failure
    respond_to do |format|
      format.html { render :gallery, status: :unprocessable_entity }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@photo),
          partial: 'photos/form',
          locals: { photo: @photo }
        ), status: :unprocessable_entity
      end
    end
  end
end
