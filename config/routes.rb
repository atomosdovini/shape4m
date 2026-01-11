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
  
  # Questionário
  get "/questionnaire", to: "questionnaires#new", as: :questionnaire
  post "/questionnaire", to: "questionnaires#create"
  
  # Admin
  get "/admin", to: "admin#index", as: :admin_index
  get "/admin/users/:user_id", to: "admin#show_user", as: :admin_user
  patch "/admin/users/:user_id/custom_plan", to: "admin#update_custom_plan", as: :admin_update_custom_plan
  get "/admin/users/:user_id/generate_prompt", to: "admin#generate_prompt", as: :admin_generate_prompt
  get "/day/:date", to: "daily_logs#show_by_date", as: :day
  get "/workout", to: "workouts#show", as: :workout
  get "/workout/:date", to: "workouts#show", as: :workout_on
  patch "/today/routine/:id/toggle", to: "routine_logs#toggle", as: :toggle_routine

  resources :daily_logs, only: [:index]
end
