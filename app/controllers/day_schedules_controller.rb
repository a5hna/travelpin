class DaySchedulesController < ApplicationController
  before_action :pundit_sucks

  def index
    @board = Board.find(params[:board_id])
    # raise
    @day_schedules = @board.day_schedules.order(date: :ASC)
    @first_day_schedule = @day_schedules[0]
    @rest_day_schedules = @day_schedules[1..-1]
     # raise
  end

  def show
  end

  def new
  end

  def update
    @day_schedule = DaySchedule.find(params[:id])
    @day_schedule.update(notes: params[:day_schedule][:notes])
    redirect_to board_day_schedules_path(@day_schedule.board)
  end

  def create
    board = Board.find(params[:board_id])
    experience_ids = params[:experiences].gsub('ids=', '').split('&')
    day_schedule = DaySchedule.where(date: params[:day_schedule][:date], board: board).first
    if day_schedule.nil?
       day_schedule = DaySchedule.create(date: params[:day_schedule][:date], board: board)
    end
    experience_ids.each do |id|
      DayScheduleItem.create(experience_id: id, day_schedule: day_schedule)
    end
    session[:date_item] = day_schedule.date
    redirect_to board_day_schedules_path
  end

   def pundit_sucks
    authorize current_user
  end

end
