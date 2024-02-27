class AppointmentTypePolicy < BasePolicy
  def method_missing(m, *args, &block)
    @current_user&.admin?
  end
end