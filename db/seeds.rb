# Create users
matt = User.create!(username: "MattBreden", password: "mattpass", email: "matt@matt.com", image_url: "http://blogdailyherald.com/wp-content/uploads/2014/10/wallpaper-for-facebook-profile-photo.jpg")
david = User.create!(username: "DavidBegert", password: "davidpass", email: "david@david.com", image_url: "http://blogdailyherald.com/wp-content/uploads/2014/10/wallpaper-for-facebook-profile-photo.jpg")
jul = User.create!(username: "Julianaosoume", password: "julanapass", email: "juliana@juliana.com", image_url: "http://blogdailyherald.com/wp-content/uploads/2014/10/wallpaper-for-facebook-profile-photo.jpg")

# Create deeds
matt_deed_1 = matt.deeds.create!(summary: "I drank a beer without paying")
matt_deed_2 = matt.deeds.create!(summary: "I ate a fish")
matt_deed_3 = matt.deeds.create!(summary: "I vommited a fish")
matt_deed_4 = matt.deeds.create!(summary: "I hid a fish in David's bed")
david_deed_1 = david.deeds.create!(summary: "I murdered a dog")
jul_deed_1 = jul.deeds.create!(summary: "I helped some people study")

# Create votes
matt_deed_1.votes.create!(value: -1, user_id: david.id)
matt_deed_1.votes.create!(value: 1, user_id: jul.id)
matt_deed_2.votes.create!(value: 1, user_id: david.id)
matt_deed_2.votes.create!(value: 1, user_id: jul.id)
matt_deed_3.votes.create!(value: -1, user_id: david.id)
matt_deed_3.votes.create!(value: -1, user_id: jul.id)
matt_deed_4.votes.create!(value: 1, user_id: jul.id)

david_deed_1.votes.create!(value: -1, user_id: matt.id)

jul_deed_1.votes.create!(value: 1, user_id: david.id)

# Add comments 

matt_deed_1.comments.create!(content: "Really special post, Matt", user_id: david.id)
matt_deed_1.comments.create!(content: "Super good bro", user_id: jul.id)
matt_deed_1.comments.create!(content: "You suck, reply to me", user_id: david.id)
matt_deed_2.comments.create!(content: "EWWWWWWW matt come on", user_id: jul.id)
