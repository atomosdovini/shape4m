class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Relacionamentos
  has_one :plan_configuration, dependent: :destroy
  has_many :daily_logs, dependent: :destroy
  has_many :routine_logs, dependent: :destroy
  
  # Validações do questionário
  validates :height_cm, presence: true, if: :questionnaire_completed?
  validates :start_weight_kg, presence: true, if: :questionnaire_completed?
  validates :objective, presence: true, inclusion: { in: %w[emagrecer definir ganhar_massa] }, if: :questionnaire_completed?
  validates :training_days_per_week, presence: true, inclusion: { in: (1..7).to_a }, if: :questionnaire_completed?
  
  def questionnaire_completed?
    questionnaire_completed == true
  end
end
