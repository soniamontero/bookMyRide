users_photos_url = [
  'https://picsum.photos/200/300?image=823',
  'https://picsum.photos/200/300?image=822',
  'https://picsum.photos/200/300?image=821',
  'https://picsum.photos/200/300?image=804',
  'https://picsum.photos/200/300?image=786'
]

rides_photos_url = [
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557997035/fks9napyzdkvdzk6gpeo.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557997031/izqcbmqaq9ocqune8fjq.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557997026/yjxwduhy0hjb1qhsvafh.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557997026/yjxwduhy0hjb1qhsvafh.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557997004/g8wtkdd7un08fx3caeyz.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557996999/ebtldvp5dyywohcxwrji.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557996987/o7isn1kdnk9wwfa7vrrz.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557996990/fstlqyogasb1ffpf5dlh.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557996969/dbbvlusczpnawycad1e6.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557996978/nbqrly1iequvjnycch5i.jpg',
  'https://res.cloudinary.com/dtr76ppq2/image/upload/c_scale,w_1000/v1557996972/bsrciezttygchr0mgyoq.jpg'
]

rides_names = [
  'Vespa 2000',
  'Turbo Vespa',
  'Nice Motorbike',
  'Easy Scooter',
  'Beautiful Ride',
  'For Rent Scooter Brand New',
  'Amazing Vespa'
]

rides_categories = [
  'Scooter',
  'Scooter',
  'Scooter',
  'Custom',
  'Motorbike'
]

users_locations = [
  'Canggu',
  'Kuta',
  'Jakarta',
  'Denpasar',
  'Singapour',
  'Shanghai'
]

sonia = User.new(
    first_name: 'Sonia',
    last_name: 'Montero',
    location: 'Canggu',
    email: 'email@email.com',
    password: 'password',
    owner: true
  )
sonia.remote_avatar_url = users_photos_url.sample
sonia.save!

ride = Ride.new(
  name: rides_names.sample,
  category: rides_categories.sample,
  price: rand(15..98),
  year: rand(1993..2019),
  description: Faker::Quotes::Shakespeare.romeo_and_juliet_quote + Faker::Quotes::Shakespeare.romeo_and_juliet_quote,
  location: sonia.location,
  user_id: sonia.id
)
ride.remote_photo_url = rides_photos_url.sample
ride.save!
p 'Sonia created and her ride created.'

user_counter = 1
ride_counter = 1
booking_counter = 0
photo_index = 0

12.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: users_locations.sample,
    email: Faker::Internet.free_email,
    password: 'password',
    owner: true
  )
  user.remote_avatar_url = users_photos_url[photo_index]
  user.save!

  unless Ride.all.empty?
    booking = Booking.new(
      date_begin: Date.today,
      date_end: Date.today + rand(1..20),
      user_id: user.id,
      ride_id: user.id - 1,
      state: 'Confirmed'
    )
    booking.save!
    booking_counter += 1
    p "#{booking_counter} bookings created."
  end

  p "#{user_counter} users created."
  user_counter += 1
  photo_index += 1
  2.times do
    ride = Ride.new(
      name: rides_names.sample,
      category: rides_categories.sample,
      price: rand(15..98),
      year: rand(1993..2019),
      location: user.location,
      description: Faker::Quotes::Shakespeare.romeo_and_juliet_quote + Faker::Quotes::Shakespeare.romeo_and_juliet_quote,
      user_id: user.id
    )
    ride.remote_photo_url = rides_photos_url.sample
    ride.save!
    p "#{ride_counter} rides created."
    ride_counter += 1
  end
end

Booking.create(
  date_begin: Date.today,
  date_end: Date.today + rand(1..20),
  user_id: 1,
  ride_id: 20,
  state: 'Confirmed'
)
booking_counter += 1
p "#{booking_counter} bookings created (Sonia)."
