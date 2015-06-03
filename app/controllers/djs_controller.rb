class DjsController < ApplicationController
  before_action :set_dj, only: [:show, :edit, :update, :destroy]

  # GET /djs
  def index
    @djs = Dj.all
  end

  # GET /djs/1
  def show
  end

  # GET /djs/new
  def new
    @dj = Dj.new
  end

  # GET /djs/1/edit
  def edit
  end

  # POST /djs
  def create
    @dj = Dj.new(dj_params)

    if @dj.save
      redirect_to @dj, notice: 'Dj was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /djs/1
  def update
    if @dj.update(dj_params)
      redirect_to @dj, notice: 'Dj was successfully updated.'
    else
      render :edit
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
      params.require(:dj).permit(:name, :bio, :short_bio, :keywords, :headshot, :slider_image)
    end
end
