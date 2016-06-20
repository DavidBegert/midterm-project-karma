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
deed = matt.deeds.create!(summary: "I drank a beer without paying", created_at: (DateTime.now - 4.days))
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: ju)

deed = david.deeds.create!(summary: "I leave the toilet seat down when I pee.", created_at: (DateTime.now - 3.days))
  #deed.votes.create!(value: -1, user: matt)
  deed.votes.create!(value: -1, user: don)
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: -1, user: dv)
  deed.votes.create!(value: -1, user: ju)
  deed.votes.create!(value: -1, user: james)
  deed.comments.create!(content: "You neanderthal! SHAME HIM ", user: don, created_at: (DateTime.now - 2.days))

deed = ju.deeds.create!(summary: "I saw a cat stuck in a tree and so I climbed up and saved it.", created_at: (DateTime.now - 2.days))
  deed.votes.create!(value: 1, user: monica)

deed = dv.deeds.create!(summary: "I baked a pie in the kitchen and did not clean up the dishes.", created_at: (DateTime.now - 1.days))
  deed.votes.create!(value: -1, user: matt)
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: don)

deed = don.deeds.create!(summary: "I promise free beer on Fridays but never actually deliver.", created_at: (DateTime.now - 1.days))
  deed.votes.create!(value: -1, user: matt)
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: dv)
  deed.votes.create!(value: -1, user: ju)
  deed.votes.create!(value: -1, user: james)

deed = james.deeds.create!(summary: "I made a free candy machine for lighthouse labs using my 3D printer!", created_at: (DateTime.now - 1.days))
  deed.votes.create!(value: 1, user: matt)
  deed.votes.create!(value: 1, user: ju)
  deed.votes.create!(value: 1, user: don)
  deed.votes.create!(value: 1, user: monica)

deed = matt.deeds.create!(summary: "I purposely make horrible merge conflicts with git and tell people to pull", created_at: (DateTime.now - 1.days))
  deed.votes.create!(value: -1, user: ju)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: -1, user: james)

deed = dv.deeds.create!(summary: "Sometimes when students ask me questions, I make a bunch of shit up and it's hilarious because they believe me.", created_at: (DateTime.now - 1.days))
  deed.votes.create!(value: 1, user: james)
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: 1, user: don)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: ju)
  deed.comments.create!(content: "Are you telling me rake db:gullible actually isn't a thing?", user: matt, created_at: (DateTime.now - 30.minutes))

deed = matt.deeds.create!(summary: "I set up a wifi hotspot next to a Starbucks with the name 'Free Starbucks Wifi' but set a password", created_at: (DateTime.now - 5.hours))
  deed.votes.create!(value: 1, user: james)
  deed.votes.create!(value: 1, user: monica)
  deed.votes.create!(value: 1, user: dv)
  deed.votes.create!(value: -1, user: don) 
  deed.comments.create!(content: "hahahahaha", user: david, created_at: (DateTime.now - 2.hours))
  deed.comments.create!(content: "That's hilarious", user: ju, created_at: (DateTime.now - 2.hours))

deed = monica.deeds.create!(summary: "I shot a man!", created_at: (DateTime.now - 4.hours))
  #deed.votes.create!(value: -1, user: matt)
  deed.votes.create!(value: -1, user: don)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: dv)
  deed.votes.create!(value: -1, user: ju)
  deed.votes.create!(value: -1, user: james)
  deed.comments.create!(content: "just to watch him die?", user: matt, created_at: (DateTime.now - 10.minutes))

deed = matt.deeds.create!(summary: "Pretty much none of my code is my own, I actually just steal 99% of it from stackoverflow", created_at: (DateTime.now - 1.hours))
  deed.votes.create!(value: 1, user: james)
  deed.votes.create!(value: 1, user: monica)

deed = david.deeds.create!(summary: "I was walking down the street and a homeless man came up to me, I told him to bugger off mate..", created_at: (DateTime.now - 30.minutes))
  deed.votes.create!(value: -1, user: james)
  deed.votes.create!(value: -1, user: monica)

deed = ju.deeds.create!(summary: "I am a serial tailgater.")
  deed.votes.create!(value: -1, user: monica)
  deed.votes.create!(value: -1, user: james)
  deed.votes.create!(value: -1, user: david)
  deed.votes.create!(value: -1, user: dv)
  deed.votes.create!(value: -1, user: don)
  deed.comments.create!(content: "that's literally the worst thing I've ever heard", user: matt)