#OtterMate 
![Otter Mate](http://36.media.tumblr.com/07d3550b444968dbb38e2687afd361d7/tumblr_np9srtfIpC1tsvscbo1_400.png)

**a social app for finding THE roomate**

for both those looking for a room 
& those with a room looking for a mate 

*to login with Ottermate*
  provide a self DESCRIPTION which will be use to generate an accessment from IBM WATSON's personality insights 
  this can be leave blank initially, however profile strength relies on personality content 


*upon signing up user can choose to*

-post a room
  * after posting a room, User will no longer be in the search mate roster
-search possible mates by gender, budget w/ acceptable range, character traits 
  * only those without a room will return in mate search
-search rooms by neighborhood, price range and pet-friendliness
  * upon listing room results user can proceed to chat with owner 

*each User will have*
  a public profile pages displaying appropriate content 
    endorsement section of roommate qualities [handy, neatfreak, punctual, active, foodie, lowkey]
    double-tapping allows for endorsement on each skills 
      don't worry confirmation will be prompted

  a tab leading to their personality assessments 
    Watson's sampling errors depends on the length of provided descriptions 

  a chat log to multiple parties of interest 
    their words compiled on top of self-description for further Personality insights 


![splash screen](http://41.media.tumblr.com/88d3d66ff10bb120d2b24324106566f8/tumblr_np9sulDM5C1tsvscbo1_1280.png)





###Stack 
Apache Cordova platform -native mobile 
Ionic UI - IOS hybrid HTML5  
AngularJs - FrontEnd framework 
Rails on Ruby & ExpressJS on Node - Backend Server 

 
###APIs for Seeding
RandomUser >> User data
Hipster IPSUM >> User description
IBM Watson Personality Insights >> user Personality accessments
StreetEasy >> most recent rental listings of NYC
