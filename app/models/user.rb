class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Relacionamentos
  has_one :plan_configuration, dependent: :destroy
  has_many :daily_logs, dependent: :destroy
  has_many :routine_logs, dependent: :destroy
end
