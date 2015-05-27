# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Chat.destroy_all
Room.destroy_all
Endorsement.destroy_all
Review.destroy_all

User.create(name: "thom", gender: "male", hasRoom: true, email: "shea@butter.com", phone: 9179209888 , password: "fireisland")
User.create(name: "thom2", gender: "female", hasRoom: false, email: "werea@utter.com", phone: 1782038889 , password: "firand")
User.create(name: "thom3", gender: "male", hasRoom: false, email: "swra@tter.com", phone: 9178823459 , password: "fireisl")
User.create(name: "thom4", gender: "female", hasRoom: false, email: "tea@ter.com", phone: 9788984569 , password: "reisland")
User.create(name: "thom5", gender: "female", hasRoom: true, email: "sheeeea@ter.com", phone: 9233898889 , password: "island")
User.create(name: "thom6", gender: "male", hasRoom: true, email: "seea@buer.com", phone: 3458333889 , password: "landfireis")
User.create(name: "thom7", gender: "male", hasRoom: false, email: "shea@butt.com", phone: 9178894248 , password: "fireland")
User.create(name: "thom8", gender: "female", hasRoom: true, email: "swera@buer.com", phone: 9178898779 , password: "fireis")
User.create(name: "thom9", gender: "male", hasRoom: true, email: "shea@ster.com", phone: 1788966689 , password: "island")

Chat.create(from_id: 1, to_id: 2, msg: "Lorem Ipsum used since the 1500s is reproduced below for those interested")
Chat.create(from_id: 3, to_id: 8, msg: "If you want to move around here ASAP but can't afford to do it without roommates")
Chat.create(from_id: 5, to_id: 7, msg: "good news: there are tons of people in your position, and I have their phone numbers")
Chat.create(from_id: 6, to_id: 5, msg: "do NOT contact me with unsolicited services or offers")
Chat.create(from_id: 3, to_id: 1, msg: "amazing renovated room in condo like! in a 3 bed share!")
Chat.create(from_id: 2, to_id: 3, msg: "Bright furnished room for sublet in Ridgewood, Queens a few blocks north of Bushwick, Brooklyn. Close to both L and M trains, a quick 30 min trip to Manhattan either way")
Chat.create(from_id: 4, to_id: 3, msg: "mid 20s roommates and a charming cat.")
Chat.create(from_id: 7, to_id: 4, msg: "Access to large kitchen, living room, bathroom (with spacious bathtub!), shared backyard, and rooftop")
Chat.create(from_id: 8, to_id: 3, msg: "June 1 for 1 to 3 months, dates are flexible. Send me a message for images and more inf")
Chat.create(from_id: 9, to_id: 1, msg: "Great area ! few steps away from grocery store, laundromat, great take out places etc....")

Room.create(owner_id: 1, price: 879, neighborhood: "crown heights", description: "Brand New Stunning Renovation Available for May 1st")
Room.create(owner_id: 5, price: 1205, neighborhood: "williamsburg", description: "Great area ! few steps away from grocery store, laundromat, great take out places etc.")
Room.create(owner_id: 6, price: 750, neighborhood: "Ridgewood", description: "Good Credit & Proof of Income Needed / Guarantors Welcome -- Utilities Not Included")
Room.create(owner_id: 8, price: 500, neighborhood: "new jersey", description: "Modern Renovation, Renovated kitchen with Steel Appliances,Central Air in all rooms,Beautiful Hardwood & Marble floors,Some units feature skylights ,Great for roommates ")
Room.create(owner_id: 9, price: 2000, neighborhood: "union square", description: "Apt is Beautifully designed Airy Clean Spacious and warm.")

Endorsement.create(endorser_id: 1, endorsee_id: 2, skill: "cleans well")
Endorsement.create(endorser_id: 8, endorsee_id: 3, skill: "pays on time") 
Endorsement.create(endorser_id: 6, endorsee_id: 4, skill: "well organize")
Endorsement.create(endorser_id: 4, endorsee_id: 2, skill: "fun and active")
Endorsement.create(endorser_id: 3, endorsee_id: 5, skill: "listens to instruction")
Endorsement.create(endorser_id: 2, endorsee_id: 6, skill: "works quietly")
Endorsement.create(endorser_id: 8, endorsee_id: 7, skill: "cooks for others")
Endorsement.create(endorser_id: 9, endorsee_id: 8, skill: "handyman")
Endorsement.create(endorser_id: 7, endorsee_id: 3, skill: "repair furniture")
Endorsement.create(endorser_id: 5, endorsee_id: 1, skill: "restock supplies")
Endorsement.create(endorser_id: 4, endorsee_id: 3, skill: "buys groceries for others")
Endorsement.create(endorser_id: 3, endorsee_id: 4, skill: "pays on time")
Endorsement.create(endorser_id: 2, endorsee_id: 3, skill: "work hard")

Review.create(room_id: 1, reviewer_id: 3, comment: "He had given me enough instructions that I felt at home and welcome in his space")
Review.create(room_id: 1, reviewer_id: 4, comment: "The location was amazing, right in the middle of Beacon Hill with easy access to the esplanade etc. ")
Review.create(room_id: 2, reviewer_id: 3, comment: " before our stay and made it easy to drop our bags and go off and see the sites. Th")
Review.create(room_id: 2, reviewer_id: 2, comment: " The stay was very comfortable with the room and the place being very clean.")
Review.create(room_id: 3, reviewer_id: 7, comment: "Stayed for 1 night for the Boston marathon. Tuomas was very helpful prior to my stay and a great host during.")
Review.create(room_id: 3, reviewer_id: 6, comment: "Tuomas was an awesome host. However, beware the 4 flights of stairs if you have a lot of luggage or are not in shape.")
Review.create(room_id: 3, reviewer_id: 5, comment: "Tuomas was very helpful and we settled in easily to his place. Would definitely stay here again. Highly recommended!")
Review.create(room_id: 4, reviewer_id: 2, comment: "This was my second time staying with Tuomas. In my prvious visit I hadn't actually met Tuomas")
Review.create(room_id: 5, reviewer_id: 1, comment: "This was a great place to stay. Tuomas worked around my odd schedule and really made me feel welcome.")
Review.create(room_id: 5, reviewer_id: 2, comment: "Great clean place, great location and great host. My stay was seamless because of Tuomas")





