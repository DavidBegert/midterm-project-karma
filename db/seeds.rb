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

# Create deeds
matt_deed_1 = matt.deeds.create!(summary: "I drank a beer without paying")
matt_deed_2 = matt.deeds.create!(summary: "I ate a fish")
matt_deed_3 = matt.deeds.create!(summary: "I vommited a fish")
matt_deed_4 = matt.deeds.create!(summary: "I hid a fish in David's bed")
david_deed_1 = david.deeds.create!(summary: "I murdered a dog")
ju_deed_1 = ju.deeds.create!(summary: "I saved a cat! Yay!")
ju_deed_2 = ju.deeds.create!(summary: "Stretch under the bed, or purr for no reason. Find something else more interesting stare at ceiling light or give attitude. Asdflkjaertvlkjasntvkjn (sits on keyboard) eat grass, throw it back up. Lick butt hide when guests come over. Cat is love, cat is life hopped up on catnip, but brown cats with pink ears hiss at vacuum cleaner and eat owner's food why must they do that spit up on light gray carpet instead of adjacent linoleum. Chew on cable kitty scratches couch bad kitty or run outside as soon as door open or stare out the window sniff other cat's butt and hang jaw half open thereafter meowzer!. Meowwww peer out window, chatter at birds, lure them to mouth i like big cats and i can not lie thug cat for pee in human's bed until he cleans the litter box. Hide from vacuum cleaner hide at bottom of staircase to trip human mark territory Gate keepers of hell.")
don_deed_1 = don.deeds.create!(summary: "I alerted you all: YOU ONLY HAVE 5 DAYS")
dv_deed_1 = dv.deeds.create!(summary: "I helped some students today")
james_deed_1 = james.deeds.create!(summary: "I made a free candy machine for LHL using my 3D printer!")
monica_deed_1 = monica.deeds.create!(summary: "Caticus cuteicus hack up furballs so chase imaginary bugs, but rub face on everything, or jump launch to pounce upon little yarn mouse, bare fangs at toy run hide in litter box until treats are fed, but stare out the window i am the best.")
monica_deed_2 = monica.deeds.create!(summary: "Make muffins hola te quiero yet gnaw the corn cob so where is my slave? I'm getting hungry. Chase red laser dot ignore the squirrels, you'll never catch them anyway, sweet beast. Lick the other cats if it smells like fish eat as much as you wish throwup on your pillow, for lounge in doorway. Human is washing you why halp oh the horror flee scratch hiss bite scratch the furniture and fall asleep on the washing machine, kick up litter and swat turds around the house and paw at your fat belly.") 
don_deed_2 = don.deeds.create!(summary: "Bacon ipsum dolor amet pork belly cupim spare ribs alcatra meatloaf shank capicola. Ribeye chicken short ribs shankle shoulder frankfurter, beef ribs leberkas pork belly flank tri-tip jerky sirloin alcatra. Biltong tenderloin picanha ball tip cupim corned beef doner capicola pancetta chicken pork.")


# Create votes
matt_deed_1.votes.create!(value: -1, user_id: david.id)
matt_deed_1.votes.create!(value: 1, user_id: ju.id)
matt_deed_2.votes.create!(value: 1, user_id: david.id)
matt_deed_2.votes.create!(value: 1, user_id: ju.id)
matt_deed_3.votes.create!(value: -1, user_id: david.id)
matt_deed_3.votes.create!(value: -1, user_id: ju.id)
matt_deed_4.votes.create!(value: 1, user_id: ju.id)

david_deed_1.votes.create!(value: -1, user_id: matt.id)

ju_deed_1.votes.create!(value: 1, user_id: david.id)

# Add comments 
matt_deed_1.comments.create!(content: "Really special post, Matt", user_id: david.id)
matt_deed_1.comments.create!(content: "Super good bro", user_id: ju.id)
matt_deed_1.comments.create!(content: "You suck, reply to me", user_id: david.id)
matt_deed_2.comments.create!(content: "EWWWWWWW matt come on", user_id: ju.id)
