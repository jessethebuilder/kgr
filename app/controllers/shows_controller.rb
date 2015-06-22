class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]
  before_action :set_calendar_events, only: [:show, :index]

  def index
    if user_is_admin?
      @shows = Show.all
    else
      @shows = Show.published
    end
  end

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

  def edit
    render :edit, :layout => 'admin_form'
  end

  def update
    if @show.update(show_params)
      @show.commit = parse_commit
      redirect_to @show, notice: "#{@show.name} was successfully updated"
    else
      render :edit, :layout => 'admin_form'
    end
  end

  def destroy
    @show.destroy
    redirect_to shows_url, :notice => 'Show was successfully destroyed'
  end

  private

  def set_show
    @show = Show.find(params[:id])
  end

  def set_calendar_events
    @calendar_events = Event.published
  end

  def show_params
    params.require(:show).permit(:name, :description, :keywords,
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