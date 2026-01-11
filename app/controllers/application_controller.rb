class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  protected
  
  def current_user
    super
  end
end
