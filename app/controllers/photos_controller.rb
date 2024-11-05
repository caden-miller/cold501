# frozen_string_literal: true

# PhotosController manages photo uploads, updates, deletions, and galleries.
# It ensures that photos are associated with users and handles validations during photo creation and updates.
class PhotosController < ApplicationController
  before_action :set_photo, except: %i[index new create gallery]

  # GET /photos
  def index
    @photos = Photo.order(id: :desc)
  end

  # GET /photos/1
  def show; end

  # GET /photos/new
  def new
    @photo = Photo.new
    respond_to do |format|
      format.turbo_stream
      format.html
    end
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
    if params[:photo].blank?
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(Photo.new), '') }
        format.html { redirect_to photos_path, alert: 'Photo creation was canceled.' }
      end
      return
    end

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
    flash.now[:notice] = 'Photo was successfully deleted.'
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to photos_path, notice: 'Photo was successfully deleted.' }
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
    flash.now[:notice] = 'Photo Created'
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'Photo Created' }
      format.turbo_stream
    end
  end

  def handle_create_failure
    flash.now[:alert] = @photo.errors.full_messages.to_sentence
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.turbo_stream { render :new, status: :unprocessable_entity }
    end
  end

  def handle_update_success
    flash.now[:notice] = 'Photo was successfully updated.'
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'Photo was successfully updated.' }
      format.turbo_stream
      
    end
  end

  def handle_update_failure
    flash[:alert] = @photo.errors.full_messages.to_sentence
    respond_to do |format|
      format.html { render :edit, status: :unprocessable_entity }
      format.turbo_stream { render :edit, status: :unprocessable_entity }
      
    end
  end
  
  
end
