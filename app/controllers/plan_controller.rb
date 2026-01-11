class PlanController < ApplicationController
  def show
    @title = Plan.title(current_user)
    @profile = Plan.profile(current_user)
    @targets = Plan.targets(current_user)
    @goals = Plan.goals(current_user)
    @rules = Plan.rules(current_user)
    @meals = Plan.meals(current_user)
    @foods = Plan.foods(current_user)
  end
end
