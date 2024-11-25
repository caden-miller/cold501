# frozen_string_literal: true

# MerchandisesController handles CRUD operations for Merchandise objects,
# including validation of Flywire links and image attachment from provided links.
class MerchandisesController < ApplicationController
  before_action :set_merchandise, only: %i[show edit update destroy]
  before_action :authenticate_admin!, only: %i[new create edit update destroy]

  # GET /merchandises or /merchandises.json
  def index
    @merchandises = Merchandise.all
  end

  # GET /merchandises/1 or /merchandises/1.json
  def show; end

  # GET /merchandises/new
  def new
    @merchandise = Merchandise.new
  end

  # GET /merchandises/1/edit
  def edit; end

  # POST /merchandises or /merchandises.json
  def create
    @merchandise = Merchandise.new(merchandise_params)

    if valid_flywire_link?(@merchandise.link)
      attach_image_from_link(@merchandise)
    else
      handle_invalid_link(:new)
      return
    end

    respond_to do |format|
      if @merchandise.save
        handle_successful_save(format, 'created')
      else
        handle_failed_save(format, :new)
      end
    end
  end

  # PATCH/PUT /merchandises/1 or /merchandises/1.json
  def update
    Rails.logger.debug("Updating Merchandise link: #{@merchandise.link}")

    if merchandise_params[:link].present? && valid_flywire_link?(merchandise_params[:link])
      attach_image_from_link(@merchandise)
    else
      handle_invalid_link(:edit)
      return
    end

    respond_to do |format|
      if @merchandise.update(merchandise_params)
        handle_successful_save(format, 'updated')
      else
        handle_failed_save(format, :edit)
      end
    end
  end

  # DELETE /merchandises/1 or /merchandises/1.json
  def destroy
    @merchandise.destroy
    respond_to do |format|
      format.html { redirect_to merchandises_url, notice: 'Merchandise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_merchandise
    @merchandise = Merchandise.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def merchandise_params
    params.require(:merchandise).permit(:link, :title, :description, :image, :stock)
  end

  # Validate Flywire link format.
  def valid_flywire_link?(link)
    link.present? && link.match?(%r{\Ahttps?://(www\.)?tamu\.estore\.flywire\.com/}i)
  end

  # Fetch and attach image from Flywire link.
  def attach_image_from_link(merchandise)
    image_url = fetch_image_url(merchandise.link)
    merchandise.image = image_url if image_url
  end

  # Fetch image URL from the provided Flywire link.
  def fetch_image_url(link)
    response = HTTParty.get(link)
    parsed_page = Nokogiri::HTML(response.body)
    image_tag = parsed_page.css('img.js-main-product-img').first || parsed_page.css('img').first
    image_url = image_tag['src'] if image_tag
    URI.join(link, image_url).to_s if image_url
  rescue StandardError => e
    Rails.logger.error("Failed to fetch image: #{e.message}")
    nil
  end

  # Handle invalid Flywire links by rendering appropriate responses.
  def handle_invalid_link(action)
    flash.now[:alert] = 'Please enter a valid Flywire link.'
    respond_to do |format|
      format.html { render action, status: :unprocessable_entity }
      format.json { render json: { error: 'Invalid Flywire link' }, status: :unprocessable_entity }
    end
  end

  # Handle successful save or update operations.
  def handle_successful_save(format, action)
    notice_message = if action == 'created'
                       'Merchandise was successfully created.'
                     else
                       'Merchandise was successfully updated.'
                     end
    format.html { redirect_to merchandises_path, notice: notice_message }
    format.json { render :index, status: action == 'created' ? :created : :ok, location: @merchandise }
  end

  # Handle failed save or update operations.
  def handle_failed_save(format, render_action)
    format.html { render render_action, status: :unprocessable_entity }
    format.json { render json: @merchandise.errors, status: :unprocessable_entity }
  end
end
