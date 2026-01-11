# app/controllers/plan_configurations_controller.rb
class PlanConfigurationsController < ApplicationController
  def edit
    @config = PlanConfiguration.current(current_user)
    # Verifica se é um novo usuário (criado há menos de 5 minutos)
    @is_new_user = current_user.created_at > 5.minutes.ago
  end
  
  def update
    @config = PlanConfiguration.current(current_user)
    @is_new_user = current_user.created_at > 5.minutes.ago
    
    # Verifica se é uma atualização parcial via JSON
    update_type = params[:update_type]
    
    if update_type.present? && (update_type == "meals_foods" || update_type == "workouts")
      # Atualização parcial via JSON
      begin
        # Faz uma cópia profunda do hash usando Marshal
        current_data = @config.data ? Marshal.load(Marshal.dump(@config.data)) : {}
        
        case update_type
        when "meals_foods"
          partial_data = JSON.parse(params[:meals_foods_json])
          merged_data = current_data.merge(partial_data)
          message = "Refeições e alimentos atualizados com sucesso!"
        when "workouts"
          partial_data = JSON.parse(params[:workouts_json])
          merged_data = current_data.merge(partial_data)
          message = "Treinos atualizados com sucesso!"
        end
        
        if @config.update(data: merged_data)
          redirect_to profile_path, notice: message
        else
          flash[:alert] = "Erro ao salvar: #{@config.errors.full_messages.join(', ')}"
          render :edit, status: :unprocessable_entity
        end
      rescue JSON::ParserError => e
        flash[:alert] = "JSON inválido: #{e.message}"
        render :edit, status: :unprocessable_entity
      end
    else
      # Atualização completa via formulário normal
      data = {
        'title' => params[:title],
        'profile' => {
          'height_cm' => params[:height_cm]&.to_i,
          'start_weight_kg' => params[:start_weight_kg]&.to_f,
          'duration_weeks' => params[:duration_weeks]&.to_i
        },
        'targets' => {
          'calories' => params[:calories]&.to_i,
          'protein_g' => params[:protein_g]&.to_i,
          'fat_g' => params[:fat_g]&.to_i,
          'carbs_g' => params[:carbs_g]&.to_i,
          'steps' => params[:steps]&.to_i,
          'water_l' => params[:water_l],
          'sleep_h' => params[:sleep_h]
        },
        'goals' => {
          'weight_target' => params[:weight_target],
          'loss_12w' => params[:loss_12w],
          'loss_16w' => params[:loss_16w]
        },
        'rules' => params[:rules]&.reject(&:blank?) || [],
        'meals' => parse_meals(params),
        'foods' => parse_foods(params),
        'workouts' => parse_workouts(params),
        'week_template' => params[:week_template]&.reject(&:blank?) || [],
        'daily_routine_template' => parse_daily_routine(params),
        'steps_blocks' => parse_steps_blocks(params)
      }
      
      if @config.update(data: data)
        redirect_to profile_path, notice: "Perfil atualizado com sucesso!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end
  
  private
  
  def parse_meals(params)
    meals = []
    (0..10).each do |i|
      next unless params["meal_#{i}_name"]&.present?
      meals << {
        'name' => params["meal_#{i}_name"],
        'options' => params["meal_#{i}_options"]&.reject(&:blank?) || []
      }
    end
    meals
  end
  
  def parse_foods(params)
    {
      'proteins' => params[:foods_proteins]&.split("\n")&.map(&:strip)&.reject(&:blank?) || [],
      'carbs' => params[:foods_carbs]&.split("\n")&.map(&:strip)&.reject(&:blank?) || [],
      'fats' => params[:foods_fats]&.split("\n")&.map(&:strip)&.reject(&:blank?) || [],
      'fibers' => params[:foods_fibers]&.split("\n")&.map(&:strip)&.reject(&:blank?) || []
    }
  end
  
  def parse_workouts(params)
    workouts = {}
    (0..10).each do |i|
      workout_name = params["workout_#{i}_name"]
      next unless workout_name&.present?
      
      exercises = []
      (0..20).each do |j|
        exercise_name = params["workout_#{i}_exercise_#{j}_name"]
        exercise_sets = params["workout_#{i}_exercise_#{j}_sets"]
        next unless exercise_name&.present?
        exercises << [exercise_name, exercise_sets]
      end
      workouts[workout_name] = exercises
    end
    workouts
  end
  
  def parse_daily_routine(params)
    routine = []
    (0..20).each do |i|
      next unless params["routine_#{i}_time"]&.present?
      routine << {
        'time' => params["routine_#{i}_time"],
        'title' => params["routine_#{i}_title"],
        'detail' => params["routine_#{i}_detail"]
      }
    end
    routine
  end
  
  def parse_steps_blocks(params)
    blocks = []
    (0..10).each do |i|
      next unless params["steps_#{i}_time"]&.present?
      blocks << {
        'time' => params["steps_#{i}_time"],
        'steps' => params["steps_#{i}_steps"]&.to_i,
        'label' => params["steps_#{i}_label"]
      }
    end
    blocks
  end
end

