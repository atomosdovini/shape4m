# app/controllers/questionnaires_controller.rb
class QuestionnairesController < ApplicationController
  def new
    # Se já completou o questionário, redireciona para o perfil
    redirect_to profile_path if current_user.questionnaire_completed?
    @user = current_user
  end
  
  def create
    @user = current_user
    
    if @user.update(questionnaire_params.merge(questionnaire_completed: true))
      # Redireciona para o perfil após completar o questionário
      redirect_to profile_path, notice: "Questionário completo! Seu plano personalizado está sendo gerado."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def questionnaire_params
    params.require(:user).permit(:height_cm, :start_weight_kg, :objective, :training_days_per_week)
  end
end

