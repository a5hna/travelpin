class DayScheduleItemsController < ApplicationController
  def destroy
    @day_schedule_item = DayScheduleItem.find(params[:id])
    @board = @day_schedule_item.day_schedule.board
    @day_schedule_item.delete
    day_schedule = @day_schedule_item.day_schedule
    if @day_schedule_item.day_schedule.day_schedule_items.length > 0
      session[:date_item] = day_schedule.date.strftime("%Y-%m-%d")
    else
      if day_schedule.board.day_schedules
        session[:date_item] = day_schedule.board.day_schedules.first.date.strftime("%Y-%m-%d")
      end
    end
    redirect_to board_day_schedules_path(@board)
  end
end
