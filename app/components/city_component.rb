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
    "city text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 #{background}"
  end

  private

  def background
    active? ? "bg-gray-300" : "bg-white"
  end
end