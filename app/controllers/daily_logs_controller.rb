class DailyLogsController < ApplicationController
  def index
    @logs = current_user.daily_logs.order(date: :desc).limit(90)
  end

  def today
    @date = Date.current
    @log = current_user.daily_logs.find_or_create_by!(date: @date) do |l|
      l.hit_protein  = false
      l.hit_calories = false
      l.hit_steps    = false
      l.did_workout  = false
      l.hit_water    = false
      l.hit_sleep    = false
    end

    # rotina inteligente (RoutineLog)
    Plan.ensure_routine_logs_for!(@date, current_user)
    @routine_logs = RoutineLog.for_date(@date, current_user)
    @next_step = @routine_logs.find { |x| !x.done }

    @workout_name = Plan.workout_for(@date, current_user)
    @workout = @workout_name ? Plan.workouts(current_user)[@workout_name] : nil
    @targets = Plan.targets(current_user)
  end

  def update_today
    log = current_user.daily_logs.find_or_create_by!(date: Date.current)
    log.update!(daily_log_params)
    redirect_to today_path, notice: "Check-in atualizado."
  end
  
  def show_by_date
    @date = Date.parse(params[:date])
    @log = current_user.daily_logs.find_by(date: @date)
    @targets = Plan.targets(current_user)
    @workout_name = Plan.workout_for(@date, current_user)
    @workout = @workout_name ? Plan.workouts(current_user)[@workout_name] : nil
  end

  private

  def daily_log_params
    params.require(:daily_log).permit(

      :weight_kg, :waist_cm, :notes,
      :hit_protein, :hit_calories, :hit_steps, :did_workout, :hit_water, :hit_sleep
    )
  end
end
