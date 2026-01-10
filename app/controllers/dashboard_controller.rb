class DashboardController < ApplicationController
  def show
    @targets = Plan::TARGETS
    @goals = Plan::GOALS

    @today = Date.current
    @log = DailyLog.find_by(date: @today)
    @workout_name = Plan.workout_for(@today)

    last_logs = DailyLog.order(date: :desc).limit(14)
    @streak = last_logs.take_while { |l| l.completed_score >= 4 }.count # “streak” leve
  end
end
