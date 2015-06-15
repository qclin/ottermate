#OtterMate 
*produced by*  **ESTAQ** 
[Evan](https://github.com/sleepylemur)
[Sebastian](https://github.com/Wiick3dLabs)
[Tom](https://github.com/TShea124)
[Anna](https://github.com/AnnaShnir)
[Qiao](https://github.com/qclin)

![Otter Mate](https://github.com/qclin/ottermate/blob/master/ionicApp/resources/ios/icon/icon-60@2x.png)

**a_social_mobile (currently ios) app for finding THE roomate**

for both those looking for a room 
& those with a room looking for a mate 

#### Sign UP with Ottermate
  provide a self DESCRIPTION which will be use to generate an accessment from IBM WATSON's personality insights 
  this can be leave blank initially, however profile strength relies on personality content 


#### upon Login up user can choose to


* post a room
    after posting a room, User will no longer be in the search mate roster
* search possible mates by gender, budget w/ acceptable range, character traits 
    only those without a room will return in mate search
* search rooms by neighborhood, price range and pet-friendliness
    upon listing room results user can proceed to chat with owner 


####each User will have


  * a public profile pages displaying appropriate content 
      endorsement section of roommate qualities [handy, neatfreak, punctual, active, foodie, lowkey]
      double-tapping allows for endorsement on each skills 
      don't worry confirmation will be prompted

  * a tab leading to their personality assessments 
      Watson's sampling errors depends on the length of provided descriptions 

  * a chat log to multiple parties of interest 
      their words compiled on top of self-description for further Personality insights

  * access to personality comparison that logs their chat history, and self-description to render a personality insight as percentages of the "Big 5" qualities. Openness, Extraversion, Agreeableness, Conscientiousness, and Emotional Range are determined as a percentage from 0 - 100%, showing a user which side of the spectrum he/she falls on as well as their potential roommate.
   

![splash screen](https://github.com/qclin/ottermate/blob/master/ionicApp/resources/ios/splash/Default~iphone.png?)


###Stack 
* Apache Cordova platform -native mobile 
* Ionic UI - IOS hybrid HTML5  
* AngularJs - FrontEnd framework 
* Rails on Ruby & ExpressJS on Node - Backend Server 

 
###APIs for Seeding
* RandomUser >> User data
* Hipster IPSUM >> User description
* IBM Watson Personality Insights >> user Personality accessments
* StreetEasy >> most recent rental listings of NYC
