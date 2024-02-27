class BasePolicy
  attr_reader :record, :current_user

  def initialize(record, current_user)
    @record = record
    @current_user = current_user
  end

  def method_missing(m, *args, &block)
    false
  end
end