class RoutineLogsController < ApplicationController
  def toggle
    log = current_user.routine_logs.find(params[:id])

    log.done = !log.done
    log.done_at = log.done ? Time.current : nil
    log.save!

    redirect_back fallback_location: today_path(tab: "day"), notice: "Atualizado."
  end
end
