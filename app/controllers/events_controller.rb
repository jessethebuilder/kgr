class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # before_action :get_all_djs, only: [:new, :edit, :update, :create]
  # before_action :process_djs_attending, only: [:create, :update]

  # GET /events
  def index
    if user_is_admin?
      @events = Event.all
    else
      @events = Event.published
    end

  end

  # GET /events/1
  def show
    # @calendar_events = Event.all
    # @djs_attending = @event.djs_attending
  end

  # GET /events/new
  def new
    @event = Event.new
    render :new, :layout => 'admin_form'
  end

  # GET /events/1/edit
  def edit
    render :edit, :layout => 'admin_form'

    # POST /events
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      @event.commit = parse_commit
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new, :layout => 'admin_form'
    end
  end

  # PATCH/PUT /events/1
  def update

    if @event.update(event_params)
      @event.commit = parse_commit
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit, :layout => 'admin_form'
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
    #
    # def get_all_djs
    #   @djs = Dj.all
    # end

    # def process_djs_attending
    #   djs = params[:djs_attending]
    #   @event.djs_attending = djs
    # end

    # Only allow a trusted parameter "white list" through.
  def event_params
    params.require(:event).permit(:name, :description, :keywords, :start_time, {:user_ids => []},
                                  :facebook_event_link,
                                  :bootsy_image_gallery_id,
                                  :main_image, :remote_main_image_url, :main_image_cache,
                                  :address_attributes => [:label, :street, :street2, :city, :state, :zip]
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
