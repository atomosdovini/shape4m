class WorkoutsController < ApplicationController
  def show
    @date =
      if params[:date].present?
        Date.parse(params[:date])
      else
        Date.current
      end

    # Semana baseada na data selecionada (segunda..sexta)
    start_of_week = @date - ((@date.wday + 6) % 7) # monday
    @week_days = (0..4).map { |i| start_of_week + i } # Mon..Fri

    @workout_name = Plan.workout_for(@date, current_user)
    @workout = @workout_name ? Plan.workouts(current_user)[@workout_name] : nil

    @prev_week_date = start_of_week - 7
    @next_week_date = start_of_week + 7
  rescue ArgumentError
    redirect_to workout_path, notice: "Data inválida."
  end
end
