User.destroy_all
AppointmentType.destroy_all
City.destroy_all
Local.destroy_all

user = User.create!(
  first_name: "Tester", last_name: "Testino potencial",
  username: 'tester1', email: 'tester1@test.com',
  phone: '123456789', password: '123456', role: 2
)

city1 = City.create!(name: "Lima")
city2 = City.create!(name: "Arequipa")
city3 = City.create!(name: "Trujillo")
city4 = City.create!(name: "Cusco")
city5 = City.create!(name: "Cajamarca")

appointment_type1 = AppointmentType.create!(
  name: "Baño", payment_required: true,
  user: user, price: 100
)

appointment_type2 = AppointmentType.create!(
  name: "Baño y corte", payment_required: true,
  user: user, price: 180
)

appointment_type3 = AppointmentType.create!(
  name: "Session spa premium", payment_required: true,
  user: user, price: 250
)

puts "Seed finished"