class DashboardController < ApplicationController
  def show
    @date = Date.current
    @targets = Plan.targets(current_user)
    @goals = Plan.goals(current_user)

    @today_log = current_user.daily_logs.find_by(date: @date)
    @workout_name = Plan.workout_for(@date, current_user)

    # Lista para o dashboard: últimos 30–90 dias (você escolhe)
    @logs = current_user.daily_logs.order(date: :desc).limit(60)

    last_logs = current_user.daily_logs.order(date: :desc).limit(14)
    @streak = last_logs.take_while { |l| l.completed_score >= 4 }.count
  end

  def update
    log = current_user.daily_logs.find_or_create_by!(date: Date.current)
    log.update!(daily_log_params)
    redirect_to root_path, notice: "Dashboard atualizado."
  end

  private

  def daily_log_params
    params.require(:daily_log).permit(
      :weight_kg, :waist_cm, :notes,
      :hit_protein, :hit_calories, :hit_steps, :did_workout, :hit_water, :hit_sleep
    )
  end

end
