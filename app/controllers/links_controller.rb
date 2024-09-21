class LinksController < ApplicationController
    before_action :set_link, only: [:show, :edit, :update, :destroy, :delete]
  
    # GET /links
    def index
      @links = Link.all
    end
  
    # GET /links/new
    def new
      @link = Link.new
    end
  
    # POST /links
    def create
      @link = Link.new(link_params)
  
      if @link.save
        redirect_to links_path, notice: 'Link was successfully created.'
      else
        render :new
      end
    end
  
    # GET /links/:id/edit
    def edit
        @link = Link.find(params[:id])
    end
  
    # PATCH/PUT /links/:id
    def update
      if @link.update(link_params)
        redirect_to links_path, notice: 'Link was successfully updated.'
      else
        render :edit
      end
    end
  
    def delete

    end
    # DELETE /links/:id
    def destroy
        @link = Link.find(params[:id])
        if @link.destroy
            flash[:success] = "Photo was successfully deleted."
            redirect_to links_path  # Redirect to index or some other page after deletion
          else
            flash[:error] = "Photo could not be deleted."
            redirect_to links_path  # Redirect back to the photo's show page if it couldn't be deleted
          end
    end
  
    private
  
    def set_link
      @link = Link.find(params[:id])
    end
  
    def link_params
      params.require(:link).permit(:title, :link)
    end
  end
  
