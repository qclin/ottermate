# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'

User.destroy_all
Chat.destroy_all
Room.destroy_all
Endorsement.destroy_all
Review.destroy_all

bool = [true, false]

words = []

100.times do 
  get_hipster = HTTParty.get("http://hipsterjesus.com/api/?paras=1")
  hipster_data = get_hipster["text"]
  words << hipster_data
end 


response = HTTParty.get("http://api.randomuser.me/?results=100")
response["results"].each_with_index do |x,i|
  User.create({username: x["user"]["username"],name: x["user"]["name"]["first"], gender: x["user"]["gender"], hasRoom: bool.sample, email: x["user"]["email"], phone: x["user"]["phone"], occupation: x["user"]["password"], password: "word#{i}", description: words.sample[21..73], watsonfeed: words[i]})
end

##### ROOMS 
owners = User.where({hasRoom: true})
owner_ids = []

owners.each do |x|
  owner_ids << x.id
end  

listings = JSON.parse(File.read('db/streetEasy.json'))
friendly = ["true", "false", "nil"]

listings.each_with_index do |x, i|
  Room.create({
    neighborhood: x["Neighborhood"],
    price: x["Price"],
    description: "address: #{x['Address']} apt #{x['Unit']}",
    petfriendly: friendly.sample,
    owner_id: owner_ids[i],
    created_at: x["Created At"]
    })
end  

##### endorsing skills all user both ways
skill_options = ["neatfreak", "punctual", "foodie", "active", "lowkey", "handy"]

400.times do 
  Endorsement.create({endorser_id: rand(100)+1 , endorsee_id: rand(100)+1, skill: skill_options.sample })
end

#### only those without a room is qualified to post reviews
qualified_reviewers = User.where({hasRoom: false})
qualified_ids = []

qualified_reviewers.each do |x|
  qualified_ids << x.id
end 

100.times do 
  Review.create(room_id:rand(50)+1, reviewer_id: qualified_ids.sample, comment: words.sample[0..50])
end 


# User.create(username: "curiousplatupus", name: "thom", gender: "male", hasRoom: false, email: "shea@butter.com", phone: "9179209888", occupation: "student", password: "fireisland", description: "friendly", watsonfeed: "Blue Bottle craft beer iPhone artisan dreamcatcher. Actually fashion axe next level leggings, street art butcher pork belly farm-to-table banh mi cronut VHS Intelligentsia meditation. Tattooed freegan master cleanse mumblecore, yr pork belly food truck skateboard four loko 3 wolf moon jean shorts biodiesel before they sold out mlkshk occupy. Master cleanse YOLO retro, beard swag tousled paleo try-hard brunch. Kogi cray cold-pressed cardigan, art party Carles hella. Bushwick vegan meh, meditation irony VHS Helvetica photo booth typewriter fixie. Letterpress post-ironic Blue Bottle, XOXO cred Marfa master cleanse quinoa cliche fanny pack cronut tofu PBR&B salvia Kickstarter.

# Before they sold out hashtag ugh Schlitz, chillwave lumbersexual four loko disrupt direct trade mustache Shoreditch twee Odd Future pop-up. Readymade locavore occupy, leggings gastropub viral wolf sartorial trust fund. Tousled narwhal mumblecore hella, food truck bicycle rights PBR&B Wes Anderson Williamsburg. Actually hashtag Austin keffiyeh, tilde aesthetic pop-up Odd Future Williamsburg readymade. Tilde meh XOXO, wayfarers cornhole pickled hoodie Neutra post-ironic aesthetic. Heirloom drinking vinegar taxidermy seitan. Pour-over single-origin coffee Echo Park, chillwave actually art party pop-up tote bag twee tousled gentrify Blue Bottle.

# +1 pork belly literally Kickstarter readymade swag polaroid Odd Future. Keytar 3 wolf moon aesthetic, kitsch leggings cray XOXO cred butcher cardigan messenger bag shabby chic. Ugh kogi meditation pop-up Intelligentsia. Plaid fixie readymade, narwhal 8-bit next level drinking vinegar quinoa mumblecore biodiesel fap Odd Future. Scenester meh butcher paleo polaroid mlkshk, pour-over ethical locavore taxidermy fingerstache whatever master cleanse. Shoreditch irony umami paleo, dreamcatcher ennui Banksy single-origin coffee deep v narwhal. Cardigan stumptown hashtag, health goth yr cronut taxidermy irony keffiyeh Thundercats occupy.

# VHS Intelligentsia sartorial meggings vinyl. Pitchfork drinking vinegar before they sold out mustache, whatever tousled lo-fi. Mlkshk pug Tumblr authentic Helvetica. Butcher Intelligentsia typewriter authentic Truffaut, chambray squid cornhole health goth listicle iPhone banh mi Schlitz lomo occupy. Fingerstache Austin raw denim, asymmetrical church-key put a bird on it cold-pressed Etsy Helvetica fanny pack bicycle rights PBR Pinterest. Church-key tote bag twee fingerstache, heirloom swag Brooklyn pickled squid sartorial deep v next level. Cronut readymade Intelligentsia Shoreditch, lo-fi selfies tattooed locavore gluten-free Marfa biodiesel fixie four dollar toast plaid mlkshk.

# Drinking vinegar dreamcatcher tote bag actually semiotics biodiesel, cold-pressed gastropub 3 wolf moon. Helvetica sustainable flexitarian, church-key ennui tofu Blue Bottle Pinterest skateboard raw denim crucifix. Pug heirloom Intelligentsia art party, normcore distillery four loko Brooklyn dreamcatcher keffiyeh hella. Squid 8-bit banh mi four loko, Etsy typewriter Intelligentsia pour-over American Apparel cliche YOLO synth Williamsburg. Wayfarers bitters normcore Intelligentsia flexitarian. PBR forage beard, tofu Intelligentsia hoodie umami American Apparel narwhal seitan Neutra Thundercats Echo Park Vice. Flexitarian synth readymade YOLO, skateboard hashtag 90's kogi street art.

# Sustainable kogi deep v, try-hard quinoa next level Banksy Neutra Intelligentsia fingerstache master cleanse twee cred Pitchfork. Umami stumptown food truck, gentrify bespoke readymade Shoreditch. Kickstarter freegan art party, migas McSweeney's Intelligentsia put a bird on it actually organic viral deep v keffiyeh Wes Anderson sartorial. Polaroid cronut vegan Truffaut. 3 wolf moon artisan sustainable twee paleo selvage. Pork belly umami cold-pressed vinyl sriracha letterpress swag, PBR&B crucifix tousled. Deep v Williamsburg fap, direct trade Etsy stumptown twee banjo food truck letterpress occupy.

# Cliche put a bird on it Pinterest YOLO, stumptown Tumblr tousled gluten-free. Selvage sartorial Banksy High Life, bespoke listicle sriracha Carles Marfa Pinterest meh biodiesel. PBR lumbersexual swag, iPhone selvage mustache church-key plaid. Intelligentsia keytar distillery cronut, taxidermy retro freegan viral mixtape. Thundercats gentrify Carles vegan, flexitarian jean shorts Pinterest YOLO biodiesel. Migas butcher gluten-free actually literally Banksy squid, fashion axe Kickstarter listicle. Gastropub four loko you probably haven't heard of them Odd Future actually swag.

# Fanny pack twee tousled slow-carb, Pitchfork Thundercats lomo squid. Gluten-free Austin swag salvia McSweeney's selfies plaid, hashtag vinyl yr whatever PBR. Pop-up chambray fap, selfies seitan forage dreamcatcher Shoreditch Blue Bottle Truffaut fashion axe freegan. Irony kale chips salvia tofu photo booth. You probably haven't heard of them flexitarian Brooklyn raw denim organic actually, normcore Shoreditch +1 selfies 8-bit street art swag. Distillery cold-pressed drinking vinegar vegan Vice hella, hashtag 8-bit mixtape before they sold out kitsch twee DIY keffiyeh pickled. Meh kale chips fixie iPhone ennui.

# Readymade listicle VHS kale chips 3 wolf moon messenger bag. 8-bit Pitchfork cold-pressed, brunch aesthetic flexitarian salvia Portland try-hard retro umami farm-to-table mlkshk bicycle rights. XOXO ennui swag four dollar toast master cleanse. Artisan seitan Kickstarter, distillery polaroid 3 wolf moon PBR&B iPhone try-hard master cleanse selvage four loko Vice before they sold out next level. Trust fund fap salvia squid lo-fi, four loko normcore PBR&B listicle pug pork belly meh lomo. Swag four loko crucifix, umami migas lomo irony you probably haven't heard of them chia deep v. You probably haven't heard of them 90's keytar cardigan.")
# User.create(username: "anymoushrew", name: "thom2", gender: "female", hasRoom: false, budget: 700, email: "werea@utter.com", phone: "1782038889", occupation: "handy-man", password: "firand", description: "clean")
# User.create(username: "e", name: "evan", gender: "male", hasRoom: true, email: "e@e.com", phone: "1111111111", occupation: "student", password: "e", description: "tired", watsonfeed: "here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text here is some text")
# User.create(username: "smashingcoco", name: "thom3", gender: "male", hasRoom: false, budget: 900, email: "swra@tter.com", phone: "9178823459", occupation: "plumper", password: "fireisl", description: "outgoing")
# User.create(username: "dummydata", name: "thom4", gender: "female", hasRoom: false, budget: 1200, email: "tea@ter.com", phone: "9788984569", occupation: "fire-fighter", password: "reisland", description: "motivated")
# User.create(username: "jumpstart", name: "thom5", gender: "female", hasRoom: true, email: "sheeeea@ter.com", phone: "9233898889", occupation: "delievery man", password: "island", description: "active")
# User.create(username: "statechange", name: "thom6", gender: "male", hasRoom: true, email: "seea@buer.com", phone: "3458333889", occupation: "skater", password: "landfireis", description: "vegan")
# User.create(username: "americanpie", name: "thom7", gender: "male", hasRoom: false, budget: 800, email: "shea@butt.com", phone: "9178894248", occupation: "go-pro", password: "fireland", description: "dog-lover")
# User.create(username: "ferristail", name: "thom8", gender: "female", hasRoom: true, email: "swera@buer.com", phone: "9178898779", occupation: "mailman", password: "fireis", description: "nerd, book-lover")
# User.create(username: "willowillo", name: "thom9", gender: "male", hasRoom: true, email: "shea@ster.com", phone: "1788966689", occupation: "instructor", password: "island", description: "likes to cook and host parties")

# Chat.create(from_id: 1, to_id: 2, msg: "Lorem Ipsum used since the 1500s is reproduced below for those interested")
# Chat.create(from_id: 3, to_id: 8, msg: "If you want to move around here ASAP but can't afford to do it without roommates")
# Chat.create(from_id: 5, to_id: 7, msg: "good news: there are tons of people in your position, and I have their phone numbers")
# Chat.create(from_id: 6, to_id: 5, msg: "do NOT contact me with unsolicited services or offers")
# Chat.create(from_id: 3, to_id: 1, msg: "amazing renovated room in condo like! in a 3 bed share!")
# Chat.create(from_id: 2, to_id: 3, msg: "Bright furnished room for sublet in Ridgewood, Queens a few blocks north of Bushwick, Brooklyn. Close to both L and M trains, a quick 30 min trip to Manhattan either way")
# Chat.create(from_id: 4, to_id: 3, msg: "mid 20s roommates and a charming cat.")
# Chat.create(from_id: 7, to_id: 4, msg: "Access to large kitchen, living room, bathroom (with spacious bathtub!), shared backyard, and rooftop")
# Chat.create(from_id: 8, to_id: 3, msg: "June 1 for 1 to 3 months, dates are flexible. Send me a message for images and more inf")
# Chat.create(from_id: 9, to_id: 1, msg: "Great area ! few steps away from grocery store, laundromat, great take out places etc....")

# Room.create(owner_id: 1, price: 879, neighborhood: "crown heights", description: "Brand New Stunning Renovation Available for May 1st", petfriendly: true)
# Room.create(owner_id: 5, price: 1205, neighborhood: "williamsburg", description: "Great area ! few steps away from grocery store, laundromat, great take out places etc.", petfriendly: true)
# Room.create(owner_id: 6, price: 750, neighborhood: "Ridgewood", description: "Good Credit & Proof of Income Needed / Guarantors Welcome -- Utilities Not Included", petfriendly: false)
# Room.create(owner_id: 8, price: 500, neighborhood: "new jersey", description: "Modern Renovation, Renovated kitchen with Steel Appliances,Central Air in all rooms,Beautiful Hardwood & Marble floors,Some units feature skylights ,Great for roommates ", petfriendly: false)
# Room.create(owner_id: 9, price: 2000, neighborhood: "union square", description: "Apt is Beautifully designed Airy Clean Spacious and warm.", petfriendly: false)

# Endorsement.create(endorser_id: 1, endorsee_id: 2, skill: "neatfreak")
# Endorsement.create(endorser_id: 3, endorsee_id: 2, skill: "neatfreak")
# Endorsement.create(endorser_id: 4, endorsee_id: 2, skill: "neatfreak")
# Endorsement.create(endorser_id: 1, endorsee_id: 2, skill: "neatfreak")
# Endorsement.create(endorser_id: 8, endorsee_id: 4, skill: "punctual") 
# Endorsement.create(endorser_id: 6, endorsee_id: 2, skill: "foodie")
# Endorsement.create(endorser_id: 4, endorsee_id: 2, skill: "punctual")
# Endorsement.create(endorser_id: 3, endorsee_id: 4, skill: "active")
# Endorsement.create(endorser_id: 2, endorsee_id: 4, skill: "active")
# Endorsement.create(endorser_id: 1, endorsee_id: 4, skill: "active")
# Endorsement.create(endorser_id: 5, endorsee_id: 4, skill: "lowkey")
# Endorsement.create(endorser_id: 2, endorsee_id: 4, skill: "lowkey")
# Endorsement.create(endorser_id: 8, endorsee_id: 2, skill: "foodie")
# Endorsement.create(endorser_id: 9, endorsee_id: 4, skill: "handy")
# Endorsement.create(endorser_id: 7, endorsee_id: 4, skill: "handy")
# Endorsement.create(endorser_id: 5, endorsee_id: 4, skill: "handy")
# Endorsement.create(endorser_id: 4, endorsee_id: 2, skill: "foodie")
# Endorsement.create(endorser_id: 3, endorsee_id: 2, skill: "punctual")
# Endorsement.create(endorser_id: 1, endorsee_id: 2, skill: "lowkey")



# Review.create(room_id: 1, reviewer_id: 3, comment: "He had given me enough instructions that I felt at home and welcome in his space")
# Review.create(room_id: 1, reviewer_id: 4, comment: "The location was amazing, right in the middle of Beacon Hill with easy access to the esplanade etc. ")
# Review.create(room_id: 2, reviewer_id: 3, comment: " before our stay and made it easy to drop our bags and go off and see the sites. Th")
# Review.create(room_id: 2, reviewer_id: 2, comment: " The stay was very comfortable with the room and the place being very clean.")
# Review.create(room_id: 3, reviewer_id: 7, comment: "Stayed for 1 night for the Boston marathon. Tuomas was very helpful prior to my stay and a great host during.")
# Review.create(room_id: 3, reviewer_id: 6, comment: "Tuomas was an awesome host. However, beware the 4 flights of stairs if you have a lot of luggage or are not in shape.")
# Review.create(room_id: 3, reviewer_id: 5, comment: "Tuomas was very helpful and we settled in easily to his place. Would definitely stay here again. Highly recommended!")
# Review.create(room_id: 4, reviewer_id: 2, comment: "This was my second time staying with Tuomas. In my prvious visit I hadn't actually met Tuomas")
# Review.create(room_id: 5, reviewer_id: 1, comment: "This was a great place to stay. Tuomas worked around my odd schedule and really made me feel welcome.")
# Review.create(room_id: 5, reviewer_id: 2, comment: "Great clean place, great location and great host. My stay was seamless because of Tuomas")





