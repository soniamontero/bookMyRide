users_photos_url = [
  "https://picsum.photos/200/300?image=823",
  "https://picsum.photos/200/300?image=822",
  "https://picsum.photos/200/300?image=821",
  "https://picsum.photos/200/300?image=804",
  "https://picsum.photos/200/300?image=786"
]

rides_photos_url = [
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550564776/anastasiia-tarasova-576846-unsplash_1.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550564789/dillon-lobo-684080-unsplash_1.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565076/tommaso-pecchioli-711600-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565063/tucker-good-731992-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565060/serge-george-540157-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565050/nick-fewings-1307214-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565050/sebastian-frohlich-371643-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565035/end-injury-260185-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565029/fatih-ozturk-1368822-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565024/nadine-shaabana-1143297-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565018/hari-nandakumar-1089470-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1550565013/fredrick-suwandi-502014-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347382/yogesh-pedamkar-1268447-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347381/simson-petrol-225289-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347378/arthur-edelman-757807-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347377/oren-lonstein-1143763-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347370/matthew-bennett-418903-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347359/josh-edgoose-1144012-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347357/fancycrave-219657-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347356/maksym-potapenko-602588-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347346/ruben-mostad-1315271-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347327/bin-thi-u-252659-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347327/giovanni-corti-626267-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347325/francisco-requena-125276-unsplash.jpg",
  "https://res.cloudinary.com/dtr76ppq2/image/upload/v1551347321/bayu-rivaldy-225227-unsplash.jpg"
]

rides_names = [
  "Vespa 2000",
  "Turbo Vespa",
  "Nice Motorbike",
  "Easy Scooter",
  "Beautiful Ride",
  "For Rent Scooter Brand New",
  "Amazing Vespa"
]

rides_categories = [
  "Scooter",
  "Scooter",
  "Scooter",
  "Custom",
  "Motorbike"
]

sonia = User.new(
    first_name: "Sonia",
    last_name: "Montero",
    location: "Canggu",
    email: "email@email.com",
    password: "password",
    owner: true
    )
sonia.remote_avatar_url = users_photos_url.sample
sonia.save!

ride = Ride.new(
    name: rides_names.sample,
    category: rides_categories.sample,
    price: rand(15..98),
    year:rand(1993..2019),
    location: sonia.location,
    user_id: sonia.id
  )
  ride.remote_photo_url = rides_photos_url.sample
  ride.save!
p "Sonia created and her ride created."

user_counter = 1
ride_counter = 1
photo_index = 0

12.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: Faker::Address.city,
    email: Faker::Internet.free_email,
    password: "password",
    owner: true
    )
  user.remote_avatar_url = users_photos_url[photo_index]
  user.save!
  p "#{user_counter} users created."
  user_counter += 1
  photo_index += 1
  2.times do
    ride = Ride.new(
      name: rides_names.sample,
      category: rides_categories.sample,
      price: rand(15..98),
      year:rand(1993..2019),
      location: user.location,
      user_id: user.id
    )
    ride.remote_photo_url = rides_photos_url.sample
    ride.save!
    p "#{ride_counter} rides created."
    ride_counter += 1
  end
end

#  booking_counter = 1

# 5.times do
#   user = User.all.sample.id
#   booking = Booking.new( user_id: user, ride_id: User.where.not(id: user).sample.id, date_begin: Date.today + rand(10..20), date_end: Date.today + rand(21..30))
#   booking.save
#   p "#{booking_counter} bookings created."
#   booking_counter += 1
# end
