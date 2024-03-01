class ColorDivComponent < ViewComponent::Base
  attr_reader :appointment_type

  def initialize(appointment_type: nil)
    @appointment_type = appointment_type
  end

  def classes
    "h-1 w-full absolute top-0 left-0 right-0"
  end

  def bg_color
    "background-color: #{background_color}"
  end

  private

  def background_color
    self.appointment_type.color
  end
end