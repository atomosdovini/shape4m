class WorkoutsController < ApplicationController
  def show
    @date = Date.current
    @workout_name = Plan.workout_for(@date)
    @workout = @workout_name ? Plan::WORKOUTS[@workout_name] : nil
  end
end
