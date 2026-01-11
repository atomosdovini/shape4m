Rails.application.routes.draw do
  devise_for :users
  get 'daily_logs/index'
  get 'workouts/show'
  get 'plan/show'
  get 'dashboard/show'
  root "dashboard#show"

  get  "/today",   to: "daily_logs#today"
  patch "/today",  to: "daily_logs#update_today"

  get "/plan",     to: "plan#show"
  get "/plan/edit", to: "plan_configurations#edit", as: :edit_plan_configuration
  patch "/plan", to: "plan_configurations#update", as: :plan_configuration
  get "/profile", to: "plan_configurations#edit", as: :profile
  patch "/dashboard", to: "dashboard#update", as: :dashboard_update
  get "/day/:date", to: "daily_logs#show_by_date", as: :day
  get "/workout", to: "workouts#show", as: :workout
  get "/workout/:date", to: "workouts#show", as: :workout_on
  patch "/today/routine/:id/toggle", to: "routine_logs#toggle", as: :toggle_routine

  resources :daily_logs, only: [:index]
end
