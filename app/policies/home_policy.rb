class HomePolicy < BasePolicy
  def dashboard_admin?
    @current_user&.admin?
  end
end