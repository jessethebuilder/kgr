class GalleryImagesController < ApplicationController
  before_action :set_gallery_image, only: [:edit, :update, :destroy]
  before_action :set_gallery, only: [:new, :create  ]

  def destroy
    @gallery_image.destroy
  end

  def edit

  end

  def update
    @gallery_image.update(gallery_image_params)
  end

  def new
    @gallery_image = GalleryImage.new
  end

  def create
    @gallery_image = GalleryImage.new(gallery_image_params)

    @gallery.gallery_images << @gallery_image


    # if @gallery_image.save
    #   redirect_to @gallery_image, notice: 'Gallery image was successfully created.'
    # else
    #   render :new
    # end
  end

  private
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_gallery_image
      @gallery_image = GalleryImage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gallery_image_params
      params.require(:gallery_image).permit(:image, :remote_image_url, :image_cache, :name, :gallery_id)
    end
end
