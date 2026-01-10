Rails.application.routes.draw do
  get 'daily_logs/index'
  get 'workouts/show'
  get 'plan/show'
  get 'dashboard/show'
  root "dashboard#show"

  get  "/today",   to: "daily_logs#today"
  patch "/today",  to: "daily_logs#update_today"

  get "/plan",     to: "plan#show"
  get "/workout",  to: "workouts#show"

  resources :daily_logs, only: [:index]
end
