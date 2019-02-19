faces_photos_url = [
  "https://picsum.photos/200/300?image=823",
  "https://picsum.photos/200/300?image=822",
  "https://picsum.photos/200/300?image=821",
  "https://picsum.photos/200/300?image=804",
  "https://picsum.photos/200/300?image=786"
]

scooter_photos_url = [
"https://unsplash.com/photos/I6lCxYNqnrs",
"https://unsplash.com/photos/wlQDgb79UAk",
"https://unsplash.com/photos/prRb5I_4MAw",
"https://unsplash.com/photos/7yBOAjW9E24",
"https://unsplash.com/photos/leAA2nRePRc",
"https://unsplash.com/photos/C22cB1D1K-s",
"https://unsplash.com/photos/MRWAGlY3VwQ",
"https://unsplash.com/photos/prhZmlhQYqE",
"https://unsplash.com/photos/TLCTWerggvA",
"https://unsplash.com/photos/dXkHfp3BrvE",
"https://unsplash.com/photos/J12pzclw8v8",
"https://unsplash.com/photos/UeLH2Brpzi8",
"https://unsplash.com/photos/o_2n6vqaKqA",
"https://unsplash.com/photos/9n3-LATMFc8",
"https://unsplash.com/photos/_rwyKyuPC2o",
"https://unsplash.com/photos/7zVKaJ5LXG8",
"https://unsplash.com/photos/w7hnKCbFWBE"
]
counter = 1

10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: Faker::Address.city,
    email: Faker::Internet.free_email,
    password: "password",
    owner: true
    )
  file = open(scooter_photos_url.sample)
  user.avatar.attach(io: file, filename: "temp.#{file.content_type_parse.first.split("/").last}", content_type: file.content_type_parse.first)
  user.save!
  p "Creating #{counter} users!"
  counter += 1
end
