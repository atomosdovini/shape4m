class DailyLogsController < ApplicationController
  def index
    @logs = DailyLog.order(date: :desc).limit(90)
  end

def today
  @date = Date.current
  @log = DailyLog.find_or_create_by!(date: @date) do |l|
    l.hit_protein  = false
    l.hit_calories = false
    l.hit_steps    = false
    l.did_workout  = false
    l.hit_water    = false
    l.hit_sleep    = false
  end

  # rotina inteligente (RoutineLog)
  Plan.ensure_routine_logs_for!(@date)
  @routine_logs = RoutineLog.for_date(@date)
  @next_step = @routine_logs.find { |x| !x.done }

  @workout_name = Plan.workout_for(@date)
  @workout = @workout_name ? Plan::WORKOUTS[@workout_name] : nil
  @targets = Plan::TARGETS
end

  def update_today
    log = DailyLog.find_or_create_by!(date: Date.current)
    log.update!(daily_log_params)
    redirect_to today_path, notice: "Check-in atualizado."
  end
def show_by_date
  @date = Date.parse(params[:date])
  @log = DailyLog.find_by(date: @date)
  @targets = Plan::TARGETS
  @workout_name = Plan.workout_for(@date)
  @workout = @workout_name ? Plan::WORKOUTS[@workout_name] : nil
end

  private

  def daily_log_params
    params.require(:daily_log).permit(

      :weight_kg, :waist_cm, :notes,
      :hit_protein, :hit_calories, :hit_steps, :did_workout, :hit_water, :hit_sleep
    )
  end
end
