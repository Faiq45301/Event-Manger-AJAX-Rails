class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy, :show]

  def index
    @events = Event.all
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      respond_to do |format|
        format.js   # renders create.js.erb
        format.html { redirect_to events_path, notice: "Event created successfully." }
      end
    else
      respond_to do |format|
        format.js   # you can later add create_error.js.erb for error rendering
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def edit
  if request.xhr?
    puts "AJAX request detected"
  else
    puts "Normal HTML request"
  end

  respond_to do |format|
    format.js
    format.html { redirect_to events_path }
  end
end


  def update
    if @event.update(event_params)
      respond_to do |format|
        format.js   # renders update.js.erb
        format.html { redirect_to events_path, notice: "Event updated successfully." }
      end
    else
      respond_to do |format|
        format.js   # add update_error.js.erb if needed
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.js   # renders destroy.js.erb
      format.html { redirect_to events_path, notice: "Event deleted successfully." }
    end
  end

  # Optional: prevent unknown route errors
  def show
    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :event_date)
  end
end
