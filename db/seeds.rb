# Create users
matt = User.create!(username: "MattBreden", 
                    password: "mattpass", 
                    email: "matt@matt.com", 
                    image_url: "/img/profile_pics/group/mbred.jpeg"
                    )
david = User.create!(username: "DavidBegert", 
                     password: "davidpass", 
                     email: "david@david.com", 
                     image_url: "/img/profile_pics/group/dbergert.jpeg"
                     )
ju = User.create!(username: "JulianaHosoume", 
                   password: "julanapass", 
                   email: "juliana@juliana.com", 
                   image_url: "/img/profile_pics/group/jhosoume.jpg"
                   )
don = User.create!(username: "DonBurks",
                   password: "donpass", 
                   email: "don@example.com",
                   image_url: "/img/profile_pics/teachers/don_burks.jpg"
                   )
dv = User.create!(username: "DavidVanDusen", 
                   password: "dvpass", 
                   email: "dv@example.com",
                   image_url: "/img/profile_pics/teachers/davidvandusen.jpg"
                   )
monica = User.create!(username: "MonicaOlinescu",
                     password: "monicapass", 
                     email: "monica@example.com",
                     image_url: "/img/profile_pics/teachers/monica.jpg"
                     )
james = User.create!(username: "JamesSapara",
                     password: "jamespass", 
                     email: "james@example.com",
                     image_url: "/img/profile_pics/teachers/james.png"
                     )

# Create deeds/votes
deed = matt.deeds.create!(summary: "I drank a beer without paying")
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: ju)

deed = david.deeds.create!(summary: "I was walking down the street and a homeless man came up to me, I told him to piss off..")
  deed.votes.create!(value: 1, user: james)
  deed.votes.create!(value: 1, user: monica)
  deed.votes.create!(value: 1, user: matt)

deed = ju.deeds.create!(summary: "I saw a cat stuck in a tree and so I climbed up and saved it.")
  deed.votes.create!(value: 1, user: monica)
  deed.votes.create!(value: 1, user: dv)
  deed.votes.create!(value: 1, user: matt)

deed = dv.deeds.create!(summary: "I baked a pie in the kitchen and did not clean up the dishes.")
  deed.votes.create!(value: -1, user: matt)
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: don)

deed = don.deeds.create!(summary: "I promise free beer on Fridays but never deliver.")
  deed.votes.create!(value: -1, user: matt)
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: dv)
  deed.votes.create!(value: -1, user: ju)
  deed.votes.create!(value: -1, user: james)

deed = james.deeds.create!(summary: "I made a free candy machine for LHL using my 3D printer!")
  deed.votes.create!(value: 1, user: matt)
  deed.votes.create!(value: 1, user: ju)
  deed.votes.create!(value: 1, user: don)
  deed.votes.create!(value: 1, user: monica)

deed = matt.deeds.create!(summary: "I purposely make horrible merge conflicts with git and tell people to pull")
  deed.votes.create!(value: -1, user: ju)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: -1, user: james)
  deed.votes.create!(value: -1, user: don)
  deed.votes.create!(value: -1, user: dv)

deed = dv.deeds.create!(summary: "When students ask me questions I sometimes gives answers that are ginormous lies and it's hilarious because they believe me.")
  deed.votes.create!(value: 1, user: james)
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: 1, user: don)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: ju)


# Add comments 
# matt_deed_1.comments.create!(content: "Really special post, Matt", user_id: david.id)
# matt_deed_1.comments.create!(content: "Super good bro", user_id: ju.id)
# matt_deed_1.comments.create!(content: "You suck, reply to me", user_id: david.id)
# matt_deed_2.comments.create!(content: "EWWWWWWW matt come on", user_id: ju.id)
