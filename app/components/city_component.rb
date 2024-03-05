class CityComponent < ViewComponent::Base
  attr_reader :city

  def initialize(city: nil)
    @city = city
  end

  def name
    city ? city.name : t('.all')
  end

  def link
    city ? dashboard_path(city_id: city.id) : dashboard_path
  end

  def active?
    return true if !@city && !params[:city_id]
    @city&.id == params[:city_id]
  end

  def classes
    "city #{text_color} px-3 py-2 rounded-xl drop-shadow-sm hover:bg-blue-400 hover:text-white #{background} font-semibold"
  end

  private

  def background
    active? ? "bg-gradient-to-r from-blue-400 to-teal-500" : "bg-white"
  end

  def text_color
    active? ? "text-white" : "text-gray-600"
  end
end