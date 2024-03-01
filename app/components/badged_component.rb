class BadgedComponent < ViewComponent::Base
  attr_reader :appointment_type

  def initialize(appointment_type: nil)
    @appointment_type = appointment_type
  end

  def classes
    "absolute top-3 right-3 w-3 h-3 rounded-full"
  end

  def bg_color
    "background-color: #{background_color}"
  end

  private

  def background_color
    self.appointment_type.color
  end
end