class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  protected
  
  def current_user
    super
  end
  
  # Redireciona novos usuários para o questionário após o registro
  def after_sign_up_path_for(resource)
    # Cria o plan_configuration se não existir
    PlanConfiguration.current(resource) unless resource.plan_configuration.present?
    # Se não completou o questionário, vai para o questionário
    resource.questionnaire_completed? ? profile_path : questionnaire_path
  end
  
  # Redireciona usuários recém-criados para o questionário na primeira vez que fazem login
  def after_sign_in_path_for(resource)
    # Se o usuário foi criado há menos de 2 minutos (recém registrado) e não completou o questionário
    if resource.created_at > 2.minutes.ago && !resource.questionnaire_completed?
      # Garante que o plan_configuration existe
      PlanConfiguration.current(resource) unless resource.plan_configuration.present?
      questionnaire_path
    elsif !resource.questionnaire_completed?
      # Se não completou o questionário, redireciona para lá
      questionnaire_path
    else
      super
    end
  end
end
