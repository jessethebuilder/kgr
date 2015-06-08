class DjsController < ApplicationController
  before_action :set_dj, only: [:show, :edit, :update, :destroy]

  # GET /djs
  def index
    @djs = Dj.all
    @calendar_events = Event.all
  end

  # GET /djs/1
  def show
    #todo Optimize
    arr = []
    Event.all.each{ |e| arr << e if e.djs_attending.include?(@dj.to_param) }
    @calendar_events = arr
  end

  # GET /djs/new
  def new
    @dj = Dj.new
    render :new, :layout => 'admin_form'
  end

  # GET /djs/1/edit
  def edit
    render :edit, :layout => 'admin_form'
  end

  # POST /djs
  def create
    @dj = Dj.new(dj_params)

    if @dj.save
      redirect_to @dj, notice: 'Dj was successfully created.'
    else
      render :new, :layout => 'admin_form'
    end
  end

  # PATCH/PUT /djs/1
  def update
    if @dj.update(dj_params)
      redirect_to @dj, notice: 'Dj was successfully updated.'
    else
      render :edit, :layout => 'admin_form'
    end
  end

  # DELETE /djs/1
  def destroy
    @dj.destroy
    redirect_to djs_url, notice: 'Dj was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dj
      @dj = Dj.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dj_params
      params.require(:dj).permit(:name, :bio, :short_bio, :keywords, :tag_line,
                                 :email, :facebook_url, :twitter_url,
                                 {:show_attributes => [:name, :description]},
                                 :bootsy_image_gallery_id,
                                 :head_shot, :remote_head_shot_url, :head_shot_cache,
                                 :slider_image, :remote_slider_image_url, :slider_image_cache)
    end
end
