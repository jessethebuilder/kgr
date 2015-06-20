class ShowsController < ApplicationController

  private

  def set_show
    @show = Show.find(params[:id])
  end

  def show_params
    params.require(:show).permit(:name, :description,
                                 :main_image, :main_image_cache, :remote_main_image,
                                 :slider_image, :slider_image_cache, :remote_slider_image,
                                 {:user_ids => []}
    )

  end

  def parse_commit
    #for SaveDraftArchiveDelete
    case params[:commit]
      when 'Save Draft'
        :draft
      when 'Publish'
        :publish
      when 'Archive'
        :archive
    end
  end
end