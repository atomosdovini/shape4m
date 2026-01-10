class PlanController < ApplicationController
  def show
    @title = Plan::TITLE
    @profile = Plan::PROFILE
    @targets = Plan::TARGETS
    @goals = Plan::GOALS
    @rules = Plan::RULES
    @meals = Plan::MEALS
    @foods = Plan::FOODS
  end
end
