# frozen_string_literal: true
require 'httparty'
require 'nokogiri'

class MerchandisesController < ApplicationController
  before_action :set_merchandise, only: %i[show edit update destroy]

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
    Rails.logger.debug("Merchandise link: #{@merchandise.link}")
  
    respond_to do |format|
      if @merchandise.link.present? && valid_flywire_link(@merchandise.link)
        image_url = get_image(@merchandise.link)
        @merchandise.image = image_url if image_url
  
        if @merchandise.save
          format.html { redirect_to merchandise_url(@merchandise), notice: 'Merchandise was successfully created.' }
          format.json { render :show, status: :created, location: @merchandise }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @merchandise.errors, status: :unprocessable_entity }
        end
      else
        flash.now[:alert] = 'Please enter a valid Flywire link.'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { error: 'Invalid Flywire link' }, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /merchandises/1 or /merchandises/1.json
  def update
    respond_to do |format|
      if @merchandise.update(merchandise_params)
        format.html { redirect_to merchandise_url(@merchandise), notice: 'Merchandise was successfully updated.' }
        format.json { render :show, status: :ok, location: @merchandise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @merchandise.errors, status: :unprocessable_entity }
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

  def valid_flywire_link(link)
      link =~ /\Ahttps?:\/\/(www\.)?tamu\.estore\.flywire\.com\//i
  end

  def get_image(link)
    response = HTTParty.get(link)
    parsed_page = Nokogiri::HTML(response.body)

     # Use the specific class name to target the product image
    image_tag = parsed_page.css('img.js-main-product-img').first

    image_tag ||= parsed_page.css('img').first
    image_url = image_tag['src'] if image_tag

    URI.join(link, image_url).to_s if image_url

  end

end
