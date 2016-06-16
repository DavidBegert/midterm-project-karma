# Create users
matt = User.create!(username: "MattBreden", password: "mattpass", email: "matt@matt.com", image_url: "http://blogdailyherald.com/wp-content/uploads/2014/10/wallpaper-for-facebook-profile-photo.jpg")
david = User.create!(username: "DavidBegert", password: "davidpass", email: "david@david.com", image_url: "http://blogdailyherald.com/wp-content/uploads/2014/10/wallpaper-for-facebook-profile-photo.jpg")
jul = User.create!(username: "Julianaosoume", password: "julanapass", email: "juliana@juliana.com", image_url: "http://blogdailyherald.com/wp-content/uploads/2014/10/wallpaper-for-facebook-profile-photo.jpg")

# Create deeds
matt_deed_1 = matt.deeds.create!(summary: "I drank a beer without paying")
david_deed_1 = david.deeds.create!(summary: "I murdered a dog")
jul_deed_1 = jul.deeds.create!(summary: "I helped some people study")

# Create votes
