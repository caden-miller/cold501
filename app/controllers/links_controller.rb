# frozen_string_literal: true

# LinksController manages the creation, viewing, editing, and deletion of links, as well as resetting points.
class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy delete]
  before_action :authenticate_admin!, only: %i[new create edit update delete]

  def index
    @links = Link.order(:id)
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # POST /links
  def create
    @link = Link.new(link_params)

    if @link.save
      handle_create_success
    else
      handle_create_failure
    end
  end

  def show; end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(dom_id(@link), partial: 'links/form', locals: { link: @link })
      end
      format.html
    end
  end

  # PATCH/PUT /links
  def update
    if @link.update(link_params)
      handle_update_success
    else
      handle_update_failure
    end
  end

  def delete; end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_path, notice: 'Link was successfully deleted.' }
      format.turbo_stream
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :link)
  end

  def handle_create_success
    Rails.logger.debug 'Link Created'
    respond_to do |format|
      format.html { redirect_to links_path, notice: 'Link was successfully created.' }
      format.turbo_stream
    end
  end

  def handle_create_failure
    Rails.logger.debug 'Link Not Created'
    render :new, status: :unprocessable_entity
  end

  def handle_update_success
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to links_path, notice: 'Link was successfully updated.' }
    end
  end

  def handle_update_failure
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@link),
          partial: 'links/form',
          locals: { link: @link }
        ), status: :unprocessable_entity
      end
    end
  end
end
