class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  def show

  end

  def new
    @show = Show.new
    render :new, layout: 'admin_form'
  end

  def create
    @show = Show.new(show_params)

    if @show.save
      @show.commit = parse_commit
      redirect_to @show, notice: 'Show was successfully created.'
    else
      render :new, layout: 'admin_form'
    end
  end

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