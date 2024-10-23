# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy delete]

  def index
    @links = Link.order(:id)
  end

  # GET /links/new
  def new
    puts 'Inside New link'
    @link = Link.new
    puts 'Leaving New link'
  end

  # POST /links
  def create
    puts 'Inside Create link'
    @link = Link.new(link_params)
    # @link = link.new(link_params)
    # @link.user = current_user

    if @link.save
      puts 'link Created'
      respond_to do |format|
        format.html { redirect_to links_path, notice: 'link Created' }
        format.turbo_stream
      end
    else
      puts 'link Not Created'
      render :new, status: :unprocessable_entity
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

  def update
    if @link.update(link_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to links_path, notice: 'link was successfully updated.' }
      end
    else
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

  def delete; end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_path, notice: 'link was successfully deleted.' }
      format.turbo_stream
    end
  end

  def leaderboard
    @links = link.order(:id)
  end

  def reset_points
    # link = link.first  # Or any specific link
    puts 'trying to update'
    Link.update_all(points: 0)
    puts 'updated'
    redirect_to links_path
    # redirect_to links_path
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(
      :title,
      :link
    )
  end
end
